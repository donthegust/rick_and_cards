import 'package:rick_and_cards/models/character_model.dart';
import 'package:rick_and_cards/models/info_model.dart';
import 'package:rick_and_cards/models/location_model.dart';
import 'package:rick_and_cards/models/origin_model.dart';

class ResponseData {
  ResponseData({
    this.info,
    this.results,
  });
  late final Info? info;
  late final List<Results>? results;

  ResponseData.fromJson(Map<String, dynamic> json) {
    info = Info.fromJson(json['info']);
    results = List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['info'] = info?.toJson();
    _data['results'] = results?.map((e) => e.toJson()).toList();
    return _data;
  }
}
