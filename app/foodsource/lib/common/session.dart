//import 'package:camera/camera.dart';
//import 'package:merp/models/employee.dart';
//import 'package:location/location.dart' as geoLocation;

class Session {
  String accessToken = '';
  String _employee;
  Map<String, double> _lastLocation;

  String get employee => _employee;

  set employee(String employee) {
    if (employee != null) {
      //employee.user.accessToken = accessToken;
    }
    _employee = employee;
  }

  Map<String, double> get lastLocation => _lastLocation;

  set lastLocation(Map<String, double> location) {
    if (location != null) {
      _lastLocation = location;
    }
  }

  static final Session _session = new Session._internal();

  factory Session() {
    return _session;
  }

  Session._internal() {
    //if (cameras == null) availableCameras().then((value) => loadCamera(value));
  }

  void clearData() {
    accessToken = '';
    employee = null;
  }
}
