// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login()
    ..userName = json['userName'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
    };
