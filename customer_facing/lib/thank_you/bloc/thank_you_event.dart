part of 'thank_you_bloc.dart';

@immutable
abstract class ThankYouEvent extends Equatable {
  const ThankYouEvent();

  @override
  List<Object?> get props => [];
}

class ThankYouLoad extends ThankYouEvent {}

class ThankYouFirebaseAdded extends ThankYouEvent {}

class ThankYouTitlesAdded extends ThankYouEvent {
  final List<Question> titlesAdded;

  const ThankYouTitlesAdded({required this.titlesAdded});

  @override
  List<Object?> get props => [titlesAdded];
}

class ThankYouFormAdded extends ThankYouEvent {
  final CustomerForm customerForm;

  const ThankYouFormAdded(this.customerForm);
  @override
  List<Object?> get props => [customerForm];
}

class ThankYouTitleAdded extends ThankYouEvent {
  final List<Question> question;

  const ThankYouTitleAdded(this.question);
  @override
  List<Object?> get props => [question];
}

class ThankYouUserEmailAdded extends ThankYouEvent {
  final String email;

  const ThankYouUserEmailAdded(this.email);
  @override
  List<Object?> get props => [email];
}
