import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchFieldBloc extends Cubit<bool> {
  SwitchFieldBloc(bool state) : super(state);

  setState(bool newState) {
    emit(newState);
  }
}
