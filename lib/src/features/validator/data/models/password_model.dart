import 'dart:convert';

import 'package:desafio_model_view/src/features/validator/domain/entities/password_entity.dart';

class PasswordModel extends PasswordEntity {
  PasswordModel({
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PasswordModel(password: $password)';
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      password: map['password'] ?? '',
    );
  }

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
