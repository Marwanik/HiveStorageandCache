import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:listwithcasheandstorage/model/handle_model.dart';

part 'cat_model.g.dart';

@HiveType(typeId: 0)
class CatModel extends ResultModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String origin;

  @HiveField(2)
  String image;

  CatModel({
    required this.name,
    required this.origin,
    required this.image,
  });

  CatModel copyWith({
    String? name,
    String? origin,
    String? image,
  }) {
    return CatModel(
      name: name ?? this.name,
      origin: origin ?? this.origin,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'origin': origin,
      'image': image,
    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      name: map['name'] as String,
      origin: map['origin'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) =>
      CatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatModel(name: $name, origin: $origin, image: $image)';

  @override
  bool operator ==(covariant CatModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.origin == origin && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ origin.hashCode ^ image.hashCode;
}
