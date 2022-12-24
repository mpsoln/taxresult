import 'form_field_base.dart';

///State object of a single form field like Dropdown
/// For now this targets only int? but this can be customized
class SingleSelectFormFieldState<ItemType, ValueType>
    extends FormFieldState<ValueType?> {
  /// List of items
  late List<ItemType> items;

  /// Indicates whther to use a default select
  late bool includeDefaultSelect;

  /// If includeDefaultSelect, the value. NULL by default
  late ValueType? defaultSelectValue;

  /// The text to show if default value is not set
  late String defaultSelectText;

  SingleSelectFormFieldState(
      {this.items = const [],
      this.includeDefaultSelect = true,
      this.defaultSelectText = "--Select--",
      this.defaultSelectValue,
      ValueType? value,
      required String fieldName,
      String? error})
      : super(value: value, error: error, fieldName: fieldName);
}

/// From field Bloc for handling a Dropdown field
/// LOVType -> Type of items in the drodown/sselect box
class SingleSelectFormFieldBloc<ItemType, ValueType> extends FormFieldBloc<
    ValueType?, SingleSelectFormFieldState<ItemType, ValueType>> {
  SingleSelectFormFieldBloc(
    SingleSelectFormFieldState<ItemType, ValueType> state, {
    List<InputFieldValidator<ValueType?>> validators = const [],
    ValueChangedHandler<ValueType?>? onValueChanged,
  }) : super(state, validators: validators, onValueChanged: onValueChanged);

  void setItems({required List<ItemType> items}) {
    // if (state.current.items.isNotEmpty) {
    //   items.insert(0, state.current.items.first);
    // }
    state.current.items = items;
    emitStateChanged();
  }
}
