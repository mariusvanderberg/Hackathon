import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:foodsource/exceptions/server_exception.dart';
import 'package:foodsource/exceptions/unauthorised_exception.dart';
import 'package:foodsource/common/session.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/repository/filter.dart';
import '../common/connectivity_checker.dart';

class Api {
  String baseUrl = 'mobile.xpedia.co.za'; //'192.168.100.67'
  int port = 8080;
  String authKey = Session().accessToken;
  String prefix = 'api';

  Future<Map> post(String resourceName, Map data, {int tries = 0}) async {
    var hasConnection = await _testConnection(resourceName);
    if (!hasConnection) {
      return null;
    }

    var httpClient = HttpClient();
    final url = '${this.baseUrl}:$port';
    var uri = Uri.http(url, "$prefix/" + resourceName.toLowerCase());

    var postData = JsonEncoder().convert(data);

    try {
      print('POST $uri');
      final httpRequest = await httpClient.postUrl(uri);
      httpRequest.headers.contentType = ContentType.json;
      if (this.authKey != null && this.authKey != '')
        httpRequest.headers.add("Authorization", "Bearer " + this.authKey);
      httpRequest.write(postData);
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode == HttpStatus.unauthorized) {
        if (tries == 0 && Session().employee != null) {
          await _renewToken();
          return await post(resourceName, data, tries: 1);
        }
        throw new UnauthorisedException(
            "Your username or password is incorrect", null);
      } else if (httpResponse.statusCode != HttpStatus.ok) {
        print("Http response $httpResponse.statusCode");
        throw new ServerException(
            "Could not log you in due to server issues, please contact the administrator",
            null);
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final jsonResponse = json.decode(responseBody);
      return jsonResponse;
    } on SocketException catch (ex) {
      print(ex.toString());
      throw new ServerException("Could not connect to the server", ex);
    }
  }

  Future<Map> update(BaseEntity entity, Map data, {int tries = 0}) async {
    var hasConnection =
        await _testConnection(entity.apiResourceName.toLowerCase());
    if (!hasConnection) {
      return null;
    }

    var httpClient = HttpClient();
    final url = this.baseUrl + ':$port';
    var uri = Uri.http(url, "api/" + entity.apiResourceName.toLowerCase());

    var putData = JsonEncoder().convert(data);

    try {
      print('PUT $uri');
      final httpRequest = await httpClient.putUrl(uri);
      httpRequest.headers.contentType = ContentType.json;
      if (this.authKey != null && this.authKey != '')
        httpRequest.headers.add("Authorization", "Bearer " + this.authKey);
      httpRequest.write(putData);
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode == HttpStatus.unauthorized) {
        if (tries == 0) {
          await _renewToken();
          return await update(entity, data, tries: 1);
        }
        throw new UnauthorisedException(
            "Your username or password is incorrect", null);
      } else if (httpResponse.statusCode != HttpStatus.ok) {
        print("Http response ${httpResponse.statusCode}");
        throw new ServerException(
            "Could not log you in due to server issues, please contact the administrator",
            null);
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final jsonResponse = json.decode(responseBody);
      return jsonResponse;
    } on SocketException catch (ex) {
      print(ex.toString());
      throw new ServerException("Could not connect to the server", ex);
    }
  }

  Future<Map> get(String resourceName,
      {String id, List<Filter> filters}) async {
    return await _get<Map>(resourceName, id: id, filters: filters);
  }

  Future<List<Map>> getList(String resourceName,
      {String id, List<Filter> filters}) async {
    var returnValue =
        await _get<List<dynamic>>(resourceName, id: id, filters: filters);

    if (returnValue == null) return returnValue;

    var mapList = new List<Map>();
    returnValue.forEach((value) => mapList.add(value));

    return mapList;
  }

  Future<T> _get<T>(String resourceName,
      {String id, List<Filter> filters, int tries = 0}) async {
    var hasConnection = await _testConnection(resourceName);
    if (!hasConnection) {
      return null;
    }

/* //Used to test the renewing of tokens
    print(tries.toString() + ' $resourceName : ' + this.authKey);
    if (tries == 0 && resourceName.toLowerCase() != 'employees') {
      this.authKey = 'abc';
      print(tries.toString() + ' $resourceName : ' + this.authKey);
    }
*/
    var httpClient = HttpClient();
    final url = this.baseUrl + ':$port';
    var uri;

    if (id == null)
      uri = Uri.http(
          url, "api/" + resourceName.toLowerCase(), this.mapFilters(filters));
    else
      uri = Uri.http(url, "api/" + resourceName.toLowerCase() + "/$id",
          this.mapFilters(filters));

    try {
      print('GET $uri');
      final httpRequest = await httpClient.getUrl(uri);
      httpRequest.headers.contentType = ContentType.json;
      if (this.authKey != null && this.authKey.length > 0) {
        httpRequest.headers.add("Authorization", "Bearer " + this.authKey);
      }
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode == HttpStatus.unauthorized) {
        if (tries == 0) {
          await _renewToken();
          return await _get<T>(resourceName,
              id: id, filters: filters, tries: 1);
        }
        throw new UnauthorisedException("Please log in first", null);
      } else if (httpResponse.statusCode != HttpStatus.ok) {
        print("Http response $httpResponse.statusCode");
        throw new ServerException(
            "Could not fetch entity [$resourceName], please contact the administrator",
            null);
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final jsonMap = json.decode(responseBody);
      return jsonMap;
    } on SocketException catch (ex) {
      print(ex.toString());
      throw new ServerException("Could not connect to the server", ex);
    }
  }

  Future<bool> testConnection() async {
    var hasConnection = await _testConnection('authenticate');
    return hasConnection;
  }

  Map<String, String> mapFilters(List<Filter> filters) {
    Map<String, String> returnValue = new Map<String, String>();

    if (filters == null) {
      return returnValue;
    }

    for (var filter in filters) {
      var name = filter.fieldName + '.' + filter.operator.stringValue;
      returnValue[name] = filter.value;
    }

    return returnValue;
  }

  Future<String> login({String username, String password}) async {
    var data = new Map();
    data['username'] = username == null && Session().employee != null
        ? Session().employee.user.login
        : username;
    data['password'] = password == null && Session().employee != null
        ? Session().employee.user.localPassword
        : password;
    var value = await post('authenticate', data);

    if (value == null) {
      return null;
    }

    var returnValue = value["id_token"];

    return returnValue;
  }

  Future<bool> _testConnection(String resourceName, {String id}) async {
    // TODO: change back to resourceName
    resourceName = 'authenticate';
    var hasConnection = await ConnectivityChecker().hasConnection(
        baseUrl, resourceName,
        prefix: prefix, port: port, id: id);

    return hasConnection;
  }

  Future<void> _renewToken() async {
    var token = await login();
    if (token == null) {
      throw new UnauthorisedException(
          "Your username or password is incorrect", null);
    }
    if (Session().employee == null) {
      throw new UnauthorisedException("No user to assign token to", null);
    }
    this.authKey = token;
    if (Session().employee != null) {
      Session().employee.user.accessToken = token;
    }
  }
}
