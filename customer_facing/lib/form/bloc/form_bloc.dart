import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  FormBloc() : super(const FormsStateLoaded()) {
    on<FormEventNumber>(_onFormEventNumber);
    on<FormEventName>(_onFormEventName);
  }

  void _onFormEventNumber(FormEventNumber event, Emitter<FormsState> emit) {
    emit(FormsStateLoaded(number: event.number, name: state.name));
  }

  void _onFormEventName(FormEventName event, Emitter<FormsState> emit) {
    emit(FormsStateLoaded(name: event.name, number: state.number));
  }
}
