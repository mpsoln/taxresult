import 'package:base/base.dart';

class SearchSelectFieldState<ItemType> extends FormFieldState<ItemType?> {
  /// List of items
  late List<ItemType> items;

  final Future<List<ItemType>> Function(String)? asyncItems;

  final bool Function(ItemType, String)? filterFn;

  final String Function(ItemType)? itemAsString;

  SearchSelectFieldState({
    this.items = const [],
    this.asyncItems,
    this.filterFn,
    this.itemAsString,
    ItemType? value,
    required String fieldName,
    String? error,
  }) : super(fieldName: fieldName, value: value, error: error);
}

class SearchSelectFieldBloc<ItemType>
    extends FormFieldBloc<ItemType?, SearchSelectFieldState<ItemType>> {
  SearchSelectFieldBloc(
    SearchSelectFieldState<ItemType> state, {
    List<InputFieldValidator<ItemType?>> validators = const [],
    ValueChangedHandler<ItemType?>? onValueChanged,
  }) : super(state, validators: validators, onValueChanged: onValueChanged);

  void setItems({required List<ItemType> items}) {
    state.current.items = items;
    emitStateChanged();
  }
}
