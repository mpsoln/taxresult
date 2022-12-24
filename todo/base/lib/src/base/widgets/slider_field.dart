import 'package:base/src/base/form/slider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Slider field using a Slider Bloc
class SliderField extends StatefulWidget {
  final int flex;

  const SliderField({
    Key? key,
    this.label,
    required this.fieldName,
    this.isEnabled = true,
    required this.bloc,
    this.displayValues = DisplayValues.current,
    this.flex = 1,
  }) : super(key: key);

  ///Label
  final String? label;

  // Field Name
  final String fieldName;

  /// Bloc that handles the slider state
  final SliderBloc bloc;

  final bool isEnabled;

  /// Display vlaues
  /// all -> Shows all the values
  ///  value -> Shows only the current value
  /// maxmin -> Shows only Max/Min without current value
  final DisplayValues displayValues;

  @override
  _SliderFieldState createState() => _SliderFieldState();
}

class _SliderFieldState extends State<SliderField> {
  @override
  Widget build(BuildContext context) {
    var value = (widget.bloc.state.current.value == null)
        ? widget.bloc.state.current.minimum
        : widget.bloc.state.current.value as double;

    return BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) => FormBuilderSlider(
            name: widget.fieldName,
            displayValues: widget.displayValues,
            divisions: widget.bloc.state.current.divisions,
            min: widget.bloc.state.current.minimum,
            max: widget.bloc.state.current.maximum,
            enabled: widget.isEnabled,
            key: ValueKey(value),
            onChangeEnd: (v) async {
              //Just set a value. This will take care of eveything
              //Use onChangeEnd() as onChanged will cause frequent UI build
              //when the slider is moved fast
              widget.bloc.setValue(v, emitStateChange: false);
            },
            initialValue: value));
  }
}
