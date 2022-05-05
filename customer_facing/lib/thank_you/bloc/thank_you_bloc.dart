import 'package:customer_facing/form/form.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:feedo_repository/feedo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'thank_you_event.dart';
part 'thank_you_state.dart';

class ThankYouBloc extends Bloc<ThankYouEvent, ThankYouState> {
  final FirebaseFeedoRepository _firebaseFeedoRepository;
  ThankYouBloc(this._firebaseFeedoRepository) : super(ThankYouInitial()) {
    on(_onLoad);
    on<ThankYouFormAdded>(_formAdded);
    on<ThankYouTitleAdded>(_titleAdded);
    on<ThankYouUserEmailAdded>(_emailAdded);
    on<ThankYouFirebaseAdded>(_thankYouFirebaseAdded);
  }

  void _onLoad(ThankYouLoad event, Emitter<ThankYouState> emit) {
    emit(const ThankYouLoaded(
      customerForm:
          CustomerForm(name: "No name given", number: "No number given"),
      email: "No email given",
      question: [],
    ));
  }

  void _formAdded(ThankYouFormAdded event, Emitter<ThankYouState> emit) {
    final state = this.state;
    if (state is ThankYouLoaded) {
      emit(ThankYouLoaded(
          customerForm: event.customerForm,
          question: state.question,
          email: state.email));
    }
  }

  void _titleAdded(ThankYouTitleAdded event, Emitter<ThankYouState> emit) {
    final state = this.state;
    if (state is ThankYouLoaded) {
      emit(ThankYouLoaded(
          customerForm: state.customerForm,
          question: event.question,
          email: state.email));
    }
  }

  void _emailAdded(ThankYouUserEmailAdded event, Emitter<ThankYouState> emit) {
    final state = this.state;
    if (state is ThankYouLoaded) {
      emit(ThankYouLoaded(
          customerForm: state.customerForm,
          question: state.question,
          email: event.email));
    }
  }

  _thankYouFirebaseAdded(
      ThankYouFirebaseAdded event, Emitter<ThankYouState> emit) async {
    final state = this.state;
    if (state is ThankYouLoaded) {
      final String condition = state.question.any((element) {
                return (element.quesNum == 1 ||
                        element.quesNum == 2 ||
                        element.quesNum == 3) &&
                    element.feedback == "NO";
              }) ==
              true
          ? "Critical"
          : "Major";

      await _firebaseFeedoRepository.addNewFeedback(Feedbacks(
        branch: state.email.substring(0, state.email.indexOf("@")),
        userEmail: state.email,
        questions: state.question,
        email: "Email not given",
        name: state.customerForm.name,
        number: state.customerForm.number,
        time: DateTime.now(),
        condition: condition,
      ));
    }
  }
}
