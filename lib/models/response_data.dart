// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rick_and_cards/models/character_model.dart';
import 'package:rick_and_cards/models/info_model.dart';

class ResponseData {
  InfoModel? info;
  List<CharacterModel?>? results;
  ResponseData({
    this.info,
    this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info?.toMap(),
      'results': results!.map((x) => x?.toMap()).toList(),
    };
  }

  factory ResponseData.fromMap(Map<String, dynamic> map) {
    return ResponseData(
      info: map['info'] != null ? InfoModel.fromMap(map['info'] as Map<String, dynamic>) : null,
      results: map['results'] != null
          ? List<CharacterModel?>.from(
              (map['results'] as List<dynamic>).map<CharacterModel?>(
                (x) => CharacterModel?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseData.fromJson(String source) => ResponseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseData(info: $info, results: $results)';
}
