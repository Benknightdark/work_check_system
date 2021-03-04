import 'package:json_annotation/json_annotation.dart';
part 'punchlist.g.dart';

@JsonSerializable()
class Punchlist {
  Punchlist();
  factory Punchlist.fromJson(Map<String, dynamic> json) =>
      _$PunchlistFromJson(json);
  Map<String, dynamic> toJson() => _$PunchlistToJson(this);
}
