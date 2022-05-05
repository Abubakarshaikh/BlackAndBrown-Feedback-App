import 'package:equatable/equatable.dart';

class Userr extends Equatable {
  final String email;
  final String password;
  const Userr({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
