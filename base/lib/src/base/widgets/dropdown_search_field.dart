import 'package:base/base.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownSearchField<ItemType> extends StatefulWidget {
  /// Label used in UI
  final String? label;

  /// Indicates whether the field is readOnly
  final bool readOnly;

  /// Indicates whether the field is mandatory
  /// This is used for adding a * to UI if it is mandatry
  final bool isMandatory;

  /// Bloc which handles this field. The items, selected value, error etc.,
  /// are all picked from the bloc
  final SearchSelectFieldBloc<ItemType> bloc;

  final Future<List<ItemType>> Function(String)? asyncItems;

  final bool Function(ItemType, String)? filterFn;

  final Widget Function(BuildContext, ItemType?)? dropdownBuilder;

  /// Input decoration if required
  final InputDecoration decoration;

  final bool showSearch;

  /// Whether the UI item is enabled
  final bool isEnabled;

  const DropdownSearchField({
    Key? key,
    required this.label,
    required this.bloc,
    this.readOnly = false,
    this.isEnabled = true,
    this.decoration = const InputDecoration(),
    this.isMandatory = false,
    this.showSearch = false,
    this.asyncItems,
    this.filterFn,
    this.dropdownBuilder,
  }) : super(key: key);

  @override
  State<DropdownSearchField<ItemType>> createState() =>
      _DropdownSearchFieldState<ItemType>();
}

class _DropdownSearchFieldState<ItemType>
    extends State<DropdownSearchField<ItemType>> {
  @override
  Widget build(BuildContext context) {
    var style = (widget.isEnabled)
        ? Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500);
    return BlocBuilder<SearchSelectFieldBloc<ItemType>,
        CubitState<SearchSelectFieldState<ItemType>>>(
      bloc: widget.bloc,
      builder: (context, state) {
        return DropdownSearch<ItemType>(
          items: state.current.items,
          selectedItem: state.current.value,
          asyncItems: state.current.asyncItems,
          filterFn: state.current.filterFn,
          itemAsString: state.current.itemAsString,
          dropdownBuilder: widget.dropdownBuilder,
          enabled: widget.isEnabled,
          compareFn: (item1, item2) => item1 == item2,
          onChanged: (value) {
            widget.bloc.setValue(value);
            widget.bloc.onValueChanged?.call(value);
          },
          popupProps: PopupProps.menu(
              showSearchBox: widget.showSearch,
              //Adjusting the Search field height
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  constraints: BoxConstraints(maxHeight: 48),
                ),
              ),
              showSelectedItems: true,
              scrollbarProps: const ScrollbarProps(
                interactive: true,
              ),
              // Adding BorderRadius to the Dropdown
              menuProps: const MenuProps(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              constraints: const BoxConstraints(maxHeight: 300),
              loadingBuilder: (_, __) => const LinearProgressIndicator()),
          clearButtonProps: const ClearButtonProps(
              isVisible: true,
              iconSize: 12,
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.close_rounded, size: 18)),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: style,
            dropdownSearchDecoration: InputDecoration(
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
          ),
        );
      },
    );
  }
}
