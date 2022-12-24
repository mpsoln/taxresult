import 'package:base/src/base/form/text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Text field that takes bloc as input and renders the Text field
/// Has an inbuilt BlocProvider so that the state changes in the bloc automatically renders
/// the control
class TextInputField extends StatefulWidget {
  final String label;

  final bool readOnly;

  final String fieldName;

  final bool obSecure;

  final bool isMandatory;

  /// The Bloc which controls the text field
  final TextFieldBloc bloc;

  final TextInputType keyboardType;

  final InputDecoration decoration;

  final bool isMultiLine;

  final int rows;

  final int maxRows;

  final bool isEnabled;

  final void Function()? onTap;

  final Widget? suffixIcon;

  final void Function(String?)? onSubmit;

  final void Function(String?)? onChange;

  final List<TextInputFormatter>? inputFormatters;

  final FocusNode? focus;

  final int flex;

  const TextInputField({
    Key? key,
    required this.label,
    required this.fieldName,
    this.readOnly = false,
    this.isEnabled = true,
    this.isMandatory = false,
    this.obSecure = false,
    this.rows = 1,
    this.maxRows = 1,
    this.isMultiLine = false,
    this.onTap,
    required this.bloc,
    this.suffixIcon,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onSubmit,
    this.onChange,
    this.focus,
    this.flex = 1,
  }) : super(key: key);

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildField(BuildContext context) {
    //Disabled color is not applied for Text Box
    //So set that manually
    var style = (widget.isEnabled)
        ? Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500);

    return BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) => FormBuilderTextField(
            focusNode: widget.focus,
            name: widget.fieldName,
            onTap: widget.onTap,
            enabled: widget.isEnabled,
            style: style,
            obscureText: widget.obSecure
                ? !widget.bloc.state.current.obSecure
                : widget.obSecure,
            minLines: widget.rows,
            maxLines: widget.maxRows,
            key: ValueKey(widget.bloc.state.current.value),
            initialValue: widget.bloc.state.current.value,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onSubmitted: widget.onSubmit,
            onChanged: (value) {
              //Set the  value of the bloc..
              widget.bloc.onValueChanged?.call(value);
              widget.bloc.setValue(value, emitStateChange: false);
              widget.onChange?.call(value);
            },
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE0E3E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.white.withOpacity(0.9),
              filled: true,
              label: RichText(
                text: TextSpan(
                    text: widget.label,
                    children: widget.isMandatory
                        ? const [
                            TextSpan(
                                text: " *", style: TextStyle(color: Colors.red))
                          ]
                        : null,
                    style: Theme.of(context).inputDecorationTheme.labelStyle),
              ),
              errorText: widget.bloc.state.current.error,
              errorStyle: const TextStyle(color: Colors.red),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: widget.obSecure
                  ? InkWell(
                      onTap: () {
                        widget.bloc.setPasswordVisibility(
                            !widget.bloc.state.current.obSecure);
                      },
                      child: widget.bloc.state.current.obSecure
                          ? const Icon(Icons.visibility,
                              color: Color(0xFF757575), size: 22)
                          : const Icon(Icons.visibility_off,
                              color: Color(0xFF757575), size: 22),
                    )
                  : widget.suffixIcon,
              // contentPadding:
              //     const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildField(context);
  }
}
