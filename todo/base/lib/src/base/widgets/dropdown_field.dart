import 'package:base/src/base/cubit_state.dart';
import 'package:base/src/base/form/single_select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Dropdown field that takes bloc as input and renders the dropdown
/// Has an inbuilt BlocProvider so that the state changes in the bloc automatically renders
/// the control
/// ValueType is the type of value the dropdown will have
/// ItemType is the type of items
class DropdownInputField<ItemType, ValueType> extends StatefulWidget {
  /// Label used in UI
  final String? label;

  /// Field Name. This can be used to identify the field and for setting server errors
  final String fieldName;

  /// Indicates whether the field is readOnly
  final bool readOnly;

  /// Indicates whether the field is mandatory
  /// This is used for adding a * to UI if it is mandatry
  final bool isMandatory;

  /// Bloc which handles this field. The items, selected value, error etc.,
  /// are all picked from the bloc
  final SingleSelectFormFieldBloc<ItemType, ValueType> bloc;

  /// Input decoration if required
  final InputDecoration decoration;

  /// Item builder to build an item in UI
  /// The items in the bloc are used to construct the UI items
  final DropdownMenuItem<ValueType?> Function(ItemType) itemBuilder;

  /// Whether the UI item is enabled
  final bool isEnabled;

  final int flex;

  const DropdownInputField({
    Key? key,
    required this.label,
    required this.fieldName,
    required this.bloc,
    this.readOnly = false,
    this.isEnabled = true,
    required this.itemBuilder,
    this.decoration = const InputDecoration(),
    this.isMandatory = false,
    this.flex = 1,
  }) : super(key: key);

  @override
  _DropdownFieldState<ItemType, ValueType> createState() =>
      _DropdownFieldState<ItemType, ValueType>();
}

class _DropdownFieldState<ItemType, ValueType>
    extends State<DropdownInputField<ItemType, ValueType>> {
  List<DropdownMenuItem<ValueType?>> _buildMenuItems() {
    List<DropdownMenuItem<ValueType?>> items = [];

    if (widget.bloc.state.current.includeDefaultSelect) {
      //Add a default item
      items.add(DropdownMenuItem<ValueType?>(
          value: widget.bloc.state.current.defaultSelectValue,
          child: Text(widget.bloc.state.current.defaultSelectText)));
    }

    for (ItemType item in widget.bloc.state.current.items) {
      items.add(widget.itemBuilder(item));
    }

    //print(items.length);
    return items;
  }

  Widget _buildField(BuildContext context) {
    var style = (widget.isEnabled)
        ? Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500);
    return BlocBuilder<SingleSelectFormFieldBloc,
            CubitState<SingleSelectFormFieldState>>(
        bloc: widget.bloc,
        builder: (context, state) {
          return FormBuilderDropdown<ValueType?>(
            name: widget.fieldName,
            /* if the items are directly provided, take them else construct with the builder */
            items: _buildMenuItems(),
            // allowClear: true,
            enabled: widget.isEnabled,
            initialValue: state.current.value,
            style: style,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              //Set the  value of the bloc..
              //That will set the value and emit state and call
              // onValuechanged handler
              widget.bloc.onValueChanged?.call(value);
              widget.bloc.setValue(value, emitStateChange: false);
            },
            decoration: InputDecoration(
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
                                text: " *", style: TextStyle(color: Colors.red))
                          ]
                        : null,
                    style: Theme.of(context).inputDecorationTheme.labelStyle),
              ),
              errorText: widget.bloc.state.current.error,
              errorStyle: const TextStyle(color: Colors.red),
              // contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildField(context);
  }
}
