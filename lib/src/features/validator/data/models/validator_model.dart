import 'dart:convert';

import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';

final class ValidatorModel extends ValidatorEntity {
  ValidatorModel({required super.id, required super.message});

  ValidatorEntity copyWith({
    String? id,
    String? message,
  }) {
    return ValidatorEntity(
      id: id ?? this.id,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
    };
  }

  factory ValidatorModel.fromMap(Map<String, dynamic> map) {
    return ValidatorModel(
      id: map['id'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidatorModel.fromJson(String source) =>
      ValidatorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ValidatorModel(id: $id, message: $message)';

  @override
  bool operator ==(covariant ValidatorModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.message == message;
  }

  @override
  int get hashCode => id.hashCode ^ message.hashCode;
}
