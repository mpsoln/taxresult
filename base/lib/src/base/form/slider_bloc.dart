import 'package:base/src/base/form/form_field_base.dart';

/// State represented by a Slier control
class SliderState extends FormFieldState<double?> {
  /// Max value
  late double minimum;

  ///  Min Value
  late double maximum;

  //Number of divisions between Max & Min
  late int divisions;

  SliderState(
      {this.minimum = 0,
      this.maximum = 0,
      required this.divisions,
      double? value,
      required String fieldName,
      String? error})
      : super(value: value, error: error, fieldName: fieldName);
}

/// Bloc for handling a slider control
class SliderBloc extends FormFieldBloc<double?, SliderState> {
  SliderBloc(
    SliderState state, {
    List<InputFieldValidator<double?>> validators = const [],
    ValueChangedHandler<double?>? onValueChanged,
  }) : super(state, validators: validators, onValueChanged: onValueChanged);
}
