import 'package:base/src/base/form/form_field_base.dart';

/// State of a Text Field
class DateTimeFieldState extends FormFieldState<DateTime?> {
  DateTimeFieldState(
      {DateTime? value, String? error, required String fieldName})
      : super(value: value, error: error, fieldName: fieldName);
}

/// Bloc for handling a text field
class DateTimeFieldBloc extends FormFieldBloc<DateTime?, DateTimeFieldState> {
  DateTimeFieldBloc(DateTimeFieldState state,
      {ValueChangedHandler<DateTime?>? onValueChanged,
      List<InputFieldValidator<DateTime?>> validators = const []})
      : super(state, validators: validators, onValueChanged: onValueChanged);
}
