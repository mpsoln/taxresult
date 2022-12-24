import 'package:base/src/base/form/date_time_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

/// Text field that takes bloc as input and renders the Text field
/// Has an inbuilt BlocProvider so that the state changes in the bloc automatically renders
/// the control
class DateTimeField extends StatefulWidget {
  final String label;

  final String fieldName;

  /// The Bloc which controls the text field
  final DateTimeFieldBloc bloc;

  final TextInputType keyboardType;

  final InputDecoration decoration;

  final bool isEnabled;

  /// Indicates whether the field is mandatory
  /// This is used for adding a * to UI if it is mandatry
  final bool isMandatory;

  final int flex;

  final DateTime? lastDate;

  final DateTime? firstDate;

  final DateTime? value;

  const DateTimeField({
    Key? key,
    required this.label,
    required this.fieldName,
    this.isEnabled = true,
    required this.bloc,
    this.isMandatory = false,
    this.value,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
    this.flex = 1,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  //TextEditingController _controller;

  @override
  void initState() {
    // this._controller = new TextEditingController(text: null);
    super.initState();
  }

  Widget _buildField(BuildContext context) {
    //this._controller = new TextEditingController(text: widget.text);

    //Disabled color is not applied for Text Box
    //So set that manually
    var style = (widget.isEnabled)
        ? const TextStyle(fontSize: 17)
        : const TextStyle()
            .copyWith(color: Theme.of(context).disabledColor, fontSize: 17);

    return BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) => FormBuilderDateTimePicker(
              name: widget.fieldName,
              enabled: widget.isEnabled,
              format: DateFormat("dd-MMM-yyyy"),
              initialValue: widget.bloc.state.current.value ?? widget.value,
              inputType: InputType.date,
              style: style,
              // Added in order to avoid future date Entry
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              key: ValueKey(widget.bloc.state.current.value),
              keyboardType: widget.keyboardType,
              onChanged: (value) {
                //Set the  value of the bloc..
                widget.bloc.setValue(value, emitStateChange: false);
              },
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: widget.decoration.copyWith(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.white.withOpacity(0.9),
                filled: true,
                label: RichText(
                  text: TextSpan(
                      text: widget.label,
                      children: widget.isMandatory
                          ? const [
                              TextSpan(
                                  text: " *",
                                  style: TextStyle(color: Colors.red))
                            ]
                          : null,
                      style: Theme.of(context).inputDecorationTheme.labelStyle),
                ),
                errorText: widget.bloc.state.current.error,
                errorStyle: const TextStyle(color: Colors.red),
                // contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildField(context);
  }
}
