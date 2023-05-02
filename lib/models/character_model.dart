// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rick_and_cards/models/location_model.dart';
import 'package:rick_and_cards/models/origin_model.dart';

class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Location? location;
  String? image;
  List<String?>? episode;
  String? url;
  DateTime? created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin?.toMap(),
      'location': location?.toMap(),
      'image': image,
      //'episode': episode.map((x) => x?.toMap()).toList(),
      'url': url,
      'created': created?.millisecondsSinceEpoch,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      species: map['species'] != null ? map['species'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      origin: map['origin'] != null ? Origin.fromMap(map['origin'] as Map<String, dynamic>) : null,
      location: map['location'] != null ? Location.fromMap(map['location'] as Map<String, dynamic>) : null,
      image: map['image'] != null ? map['image'] as String : null,
      //episode: map['episode'] != null ? List<String?>.from((map['episode'] as List<int>).map<String??>((x) => String?.fromMap(x as Map<String,dynamic>),),) : null,
      url: map['url'] != null ? map['url'] as String : null,
      // created: map['created'] != null ? DateTime.fromMillisecondsSinceEpoch(map['created'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) => CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }
}
