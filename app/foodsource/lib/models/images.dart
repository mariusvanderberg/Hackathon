import 'dart:convert';
import 'dart:typed_data';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/target.dart';

class Images extends BaseEntity {
  @override
  get tableName => 'Images';

  @override
  get apiResourceName => 'images';

  String fileName = '';
  num latitude;
  num longitude;
  Uint8List imageData;
  ByteData imageBytes;
  String imageContentType = 'image/png'; //png or jpeg

  String jobId;
  Job job = new Job();

  String targetId;
  Target target = new Target();

  @override
  Map<String, dynamic> toMap() {
//    fileName = 'JobImage_'+job.createdDate.toString();
    super.toMap();
    super.map['image'] = base64Encode(imageData);
    super.map['latitude'] = latitude;
    super.map['longitude'] = longitude;
    super.map['fileName'] = fileName;
    super.map['imageContentType'] = imageContentType;
    super.map['jobId'] = jobId;
    super.map['targetId'] = targetId;

    if (job != null) {
      super.map['job'] = job.toMap();
    }

    if (target != null) {
      super.map['target'] = target.toMap();
    }

    return super.map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);

    this.id = map['id'].toString();
    this.fileName = map['fileName'];
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
    this.imageData = base64Decode(map['image']);
    this.imageContentType = map['imageContentType'];
    /*HexDecoder hexDecoder;

    this.imageData = hexDecoder.convert(map['image']);*/

    if (map.containsKey('jobId')) {
      jobId = map['jobId'];
    }

    if (map.containsKey('job')) {
      var jobMap = map['job'];
      if (jobMap != null) {
        job = new Job();
        job.fromMap(jobMap);
        jobId = job.id;
      }
    }

    if (map.containsKey('targetId')) {
      targetId = map['targetId'];
    }

    if (map.containsKey('target')) {
      var targetMap = map['target'];
      if (targetMap != null) {
        target = new Target();
        target.fromMap(targetMap);
        targetId = target.id;
      }
    }
  }
}
