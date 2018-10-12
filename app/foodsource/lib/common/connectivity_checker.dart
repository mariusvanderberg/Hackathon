import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class ConnectivityChecker {
  static const TIMEOUT = const Duration(milliseconds: 5000);
  static final ConnectivityChecker _connectivityChecker =
      new ConnectivityChecker._internal();

  factory ConnectivityChecker() {
    return _connectivityChecker;
  }

  ConnectivityChecker._internal();

  Future<bool> hasConnection(String host, String resourceName,
      {String prefix, String id, int port}) async {
    if (!await hasNetwork()) {
      return false;
    }

    var endpointString = host;
    if (port != null) {
      endpointString = endpointString + ':' + port.toString();
    }
    if (prefix != null) {
      resourceName = prefix + '/' + resourceName;
    }
    if (id != null) {
      resourceName = resourceName + '/' + id;
    }

    var isSuccessful = true;
    var httpClient = HttpClient();
    var uri = Uri.http(endpointString, resourceName);
    try {
      var httpRequest = await httpClient
          .openUrl('OPTIONS', uri)
          .timeout(TIMEOUT)
          .catchError((exception) => throw new SocketException('Timeout'));
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode == HttpStatus.ok && isSuccessful) {
        return true;
      } else {
        print(
            'Cannot connect to server. ' + httpResponse.statusCode.toString());
        return false;
      }
    } on SocketException catch (ex) {
      print('SocketException: Cannot connect to server. ' + ex.toString());
      return false;
    }
  }

  Future<bool> hasNetwork() async {
    var result = false;
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      result = false;
    } else {
      result = true;
    }

    print('Connectivity result is: $connectivityResult');

    return result;
  }
}
