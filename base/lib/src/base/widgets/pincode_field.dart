import 'dart:async';

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PincodeInputField extends StatefulWidget {
  final int length;
  final TextFieldBloc bloc;

  const PincodeInputField({
    Key? key,
    required this.bloc,
    required this.length,
  }) : super(key: key);

  @override
  _PincodeInputFieldState createState() => _PincodeInputFieldState();
}

class _PincodeInputFieldState extends State<PincodeInputField> {
  late StreamController<ErrorAnimationType>? _errorController;

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  Widget _buildField() {
    return PinCodeTextField(
      appContext: context,
      length: widget.length,
      pastedTextStyle: TextStyle(
        color: Colors.green.shade600,
        fontWeight: FontWeight.bold,
      ),
      obscureText: true,
      obscuringCharacter: '*',
      keyboardType: TextInputType.number,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onChanged: (value) {
        widget.bloc.setValue(value, emitStateChange: false);
      },
    );
  }

  Widget _buildErrorText() {
    return BlocBuilder(
      bloc: widget.bloc,
      builder: (context, state) {
        if (widget.bloc.state.current.error != null) {
          _errorController?.addError(ErrorAnimationType.shake);
          return Text(
            widget.bloc.state.current.error!,
            style: const TextStyle(color: Colors.red),
          );
        }
        return ViewHelpers.buildEmptyWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(),
        _buildErrorText(),
      ],
    );
  }
}
