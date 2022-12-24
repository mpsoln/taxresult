/* By default a text box bloc is of string type */

import 'package:base/src/base/cubit_base.dart';
import 'package:base/src/base/cubit_state.dart';
import 'package:flutter/material.dart';

/// Validator funtion. Takes an input and returns a String if that is invalid
/// Returns NULL if no error
typedef InputFieldValidator<T> = Future<String?> Function(T? value);
// typedef Future<String?> InputFieldValidator<T>(T? value);

///Value changed handler
typedef ValueChangedHandler<T> = void Function(T? value);
// typedef void ValueChangedHandler<T>(T? value);

/// Base class for all Input/Form field states
class FormFieldState<T> {
  /// Value of the form field
  T? value;

  /// Validation Error of the field. NULL indicates no validation error
  /// Currently one validation error is supported for one field
  /// This can be customized to an array in future
  String? error;

  /// The corresponding field name. This can be used to handle server errors
  String fieldName;

  FormFieldState({this.value, this.error, required this.fieldName});

  bool get isValid => (error != null);
}

/// Base Bloc class for a Form Field
/// Since this is Bloc class, this can be used to trigger emit when the value of the field changes
/// All the form field class will inehrit from this
/// valueType ->  Type of the value that the field stores
abstract class FormFieldBloc<ValueType,
    StateType extends FormFieldState<ValueType>> extends CubitBase<StateType> {
  FormFieldBloc(StateType initialState,
      {this.validators = const [], this.onValueChanged})
      : super(CubitState(initialState));

  /// Sets a value for the field and emits() state
  void setValue(ValueType? value, {bool emitStateChange = true}) {
    state.current.error = null;
    state.current.value = value;

    if (onValueChanged != null) {
      onValueChanged?.call(state.current.value);
    }

    if (emitStateChange) {
      emitStateChanged();
    }
  }

  /// Emits the current state as new object
  /// As said in CubitBase(), when we emit() the sme state object, emit() wil not happen
  /// So wrap the state into a CubitState object
  @protected
  void emitCurrentState() {
    emit(CubitState(state.current,
        isSubmitting: state.isSubmitting,
        isFailure: state.isFailure,
        isLoading: state.isLoading,
        isSuccess: state.isSuccess));
  }

  /// List of validators if any
  List<InputFieldValidator<ValueType>> validators = [];

  /// Sets the error and emits the state for the UI to refresh
  void setError(String error) {
    state.current.error = error;
    emitCurrentState();
  }

  /// Value Changed handler
  ValueChangedHandler<ValueType>? onValueChanged;

  /// Clears the validation error
  void clearError() {
    state.current.error = null;
    emitCurrentState();
  }

  /// Validates the Bloc by calling Validate() of each bloc inside this form
  /// This can be customied by the derived classses as required
  Future<bool> validate() async {
    //Call each validator and set the validation errors..
    //Clear the error
    state.current.error = null;

    for (var val in validators) {
      var error = await val(state.current.value);

      if (error != null) {
        //There is a validation error...

        setError(error);
        return false;
      }
    }
    //No errors
    return true;
  }
}
