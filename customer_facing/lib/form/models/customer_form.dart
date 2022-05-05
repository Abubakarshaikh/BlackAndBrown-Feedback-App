import 'package:equatable/equatable.dart';

class CustomerForm extends Equatable {
  final String number;
  final String name;

  const CustomerForm({required this.number, required this.name});
  @override
  List<Object?> get props => [number, name];
}
