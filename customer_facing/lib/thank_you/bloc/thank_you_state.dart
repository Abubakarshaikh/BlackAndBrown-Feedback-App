part of 'thank_you_bloc.dart';

@immutable
abstract class ThankYouState extends Equatable {
  const ThankYouState();

  @override
  List<Object?> get props => [];
}

class ThankYouLoaded extends ThankYouState {
  final CustomerForm customerForm;
  final List<Question> question;
  final String email;

  const ThankYouLoaded(
      {
      required this.customerForm,
      required this.question,
      required this.email});
  @override
  List<Object?> get props => [customerForm, question, email];
}

class ThankYouInitial extends ThankYouState {}

class ThankYouError extends ThankYouState {}
