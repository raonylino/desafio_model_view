// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class ValidatorEntity {
  final String id;
  final String message;
  final String password;

  ValidatorEntity({
    required this.id,
    required this.message,
    required this.password,
  });
}
