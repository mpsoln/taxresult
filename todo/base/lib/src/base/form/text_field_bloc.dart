import 'form_field_base.dart';

/// State of a Text Field
class TextFieldState extends FormFieldState<String?> {
  bool obSecure = false;

  TextFieldState({String? value, String? error, required String fieldName})
      : super(value: value, error: error, fieldName: fieldName);
}

/// Bloc for handling a text field
class TextFieldBloc extends FormFieldBloc<String?, TextFieldState> {
  TextFieldBloc(TextFieldState state,
      {ValueChangedHandler<String?>? onValueChanged,
      List<InputFieldValidator<String?>> validators = const []})
      : super(state, validators: validators, onValueChanged: onValueChanged);

  void setPasswordVisibility(bool visibility) {
    state.current.obSecure = visibility;
    emitStateChanged();
  }
}
