import 'package:base/src/base/form/switch_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwithField extends StatefulWidget {
  final Widget label;
  final SwitchFieldBloc bloc;
  final bool isEnabled;
  final int flex;
  const SwithField(
      {Key? key,
      required this.bloc,
      required this.label,
      this.isEnabled = true,
      this.flex = 1})
      : super(key: key);

  @override
  State<SwithField> createState() => _SwithFieldState();
}

class _SwithFieldState extends State<SwithField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchFieldBloc, bool>(
        bloc: widget.bloc,
        builder: (context, state) {
          return Row(
            children: [
              widget.label,
              const SizedBox(width: 10),
              Switch(
                value: state,
                onChanged: widget.isEnabled
                    ? (value) => widget.bloc.setState(value)
                    : null,
              )
            ],
          );
        });
  }
}
