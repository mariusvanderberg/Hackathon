import 'package:foodsource/models/base_entity.dart';

class Address extends BaseEntity {
  @override
  get tableName => 'Address';
  @override
  get apiResourceName => 'addresses';

  String name;
  String addressLine1;
  String addressLine2;
  String postalCode;
  String provinceState;
  String country;
  double latitude;
  double longitude;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['addressLine1'] = addressLine1;
    super.map['addressLine2'] = addressLine2;
    super.map['postalCode'] = postalCode;
    super.map['provinceState'] = provinceState;
    super.map['country'] = country;
    super.map['latitude'] = latitude;
    super.map['longitude'] = longitude;

    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) {
      return;
    }

    super.fromMap(map);
    name = map['name'];
    addressLine1 = map['addressLine1'];
    addressLine2 = map['addressLine2'];
    postalCode = map['postalCode'];
    provinceState = map['provinceState'];
    country = map['country'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }
}
