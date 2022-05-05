part of 'form_bloc.dart';

@immutable
abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object?> get props => [];
}

class FormEventNumber extends FormEvent {
  final String number;
  const FormEventNumber({required this.number});

  @override
  List<Object?> get props => [number];
}

class FormEventName extends FormEvent {
  final String name;
  const FormEventName({required this.name});

  @override
  List<Object?> get props => [name];
}
