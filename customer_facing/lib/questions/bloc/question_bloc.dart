import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedo_repository/feedo_repository.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final FirebaseFeedoRepository _firebaseFeedoRepository;
  QuestionBloc(this._firebaseFeedoRepository) : super(QuestionInitial()) {
    on<QuestionLoad>(_questionLoad);
    on<QuestionUpdate>(_questionUpdate);
  }

  Future<void> _questionLoad(
      QuestionLoad event, Emitter<QuestionState> emit) async {
    emit(QuestionLoaded(await _firebaseFeedoRepository.loadQuestions()));
  }

  void _questionUpdate(QuestionUpdate event, Emitter<QuestionState> emit) {
    final state = this.state;
    if (state is QuestionLoaded) {
      final List<Question> updatedState =
          List.from(state.questionLoaded.map((Question question) {
        return question.quesNum == event.updatedQuestion.quesNum
            ? event.updatedQuestion
            : question;
      }).toList());
      emit(QuestionLoaded(updatedState));
    }
  }
}
