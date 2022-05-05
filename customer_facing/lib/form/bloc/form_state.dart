part of 'form_bloc.dart';

@immutable
abstract class FormsState extends Equatable {
  final String? number;
  final String? name;
  const FormsState({required this.number, required this.name});

  @override
  List<Object?> get props => [number, name];
}

class FormsStateLoaded extends FormsState {
  const FormsStateLoaded({String? number, String? name})
      : super(name: name, number: number);
}
