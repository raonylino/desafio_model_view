// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';

class ValidatorModel extends ValidatorEntity {
  final String password;

  ValidatorModel({
    required super.id,
    required super.message,
    required this.password,
  }) : super(password: password);

  ValidatorEntity copyWith({
    String? id,
    String? message,
    String? password,
  }) {
    return ValidatorModel(
      id: id ?? this.id,
      message: message ?? this.message,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'password': password,
    };
  }

  factory ValidatorModel.fromMap(Map<String, dynamic> map) {
    return ValidatorModel(
      id: map['id'] as String,
      message: map['message'] as String,
      password: map['password'] ?? 'default_password',
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidatorModel.fromJson(String source) =>
      ValidatorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ValidatorModel(id: $id, message: $message, password: $password)';

  @override
  bool operator ==(covariant ValidatorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.message == message &&
        other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ password.hashCode;
}
