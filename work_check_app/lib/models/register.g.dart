// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register()
    ..userName = json['userName'] as String
    ..password = json['password'] as String
    ..displayName = json['displayName'] as String
    ..email = json['email'] as String;
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'displayName': instance.displayName,
      'email': instance.email,
    };
