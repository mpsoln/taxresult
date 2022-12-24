import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'cubit_state.dart';
import 'cubit_states.dart';
import 'errors.dart';

/// Base class for all cubit items
/// All the classes will inherit from this
class CubitBase<T> extends Cubit<CubitState<T>> {
  CubitBase(CubitState<T> initialState) : super(initialState);

  //Handle all the cleaning/disposing functionalities
  @mustCallSuper
  void dispose() {
    close();
  }

  /// Gets a new state based on the current state
  /// When we emit() state, it will not trigger emit() if the object is same
  ///So wrap the obnject into cubitstate object and crete a new object
  ///of cubit state everytime so that it gets emitted
  @protected
  CubitState<T> getNewState() {
    //Gets a new state

    if (state is CubitLoadingState<T>) {
      return CubitLoadingState<T>(state.current,
          loadingStatus: (state as CubitLoadingState<T>).loadingStatus);
    } else if (state is CubitLoadedState<T>) {
      return CubitLoadedState<T>(state.current);
    } else if (state is CubitFailureState<T>) {
      var errState = state as CubitFailureState<T>;
      // print(errState.errors?.length.toString());
      return CubitFailureState<T>(state.current, errState.failureMessage,
          errors: errState.errors);
    } else {
      //Normal State
      return CubitState<T>(state.current);
    }
    //this.emit(new CubitState<T>(this.state.current));
  }

  /// Emits a state change event based on the current state for the UI to refresh
  void emitStateChanged() {
    emit(getNewState());
  }

  /// Emits a success state change. Typically this is a succes state on submit()
  void emitSuccessState<S>({S? response}) {
    emit(state.toSuccessState(response));
  }

  /// Emits a failure state with errors. For ex:- Validation error
  void emitFailureState(String failureMessage,
      {List<ValidationError>? errors}) {
    emit(state.toFailureState(failureMessage, errors));
  }

  /// Indicates a Loading state. Use this to show progress if any
  void emitLoadingState({double progress = 0.0, String message = "Loading"}) {
    emit(state.toLoadingState(loadingStatus: message, progress: progress));
  }

  /// Emits a completed/loaded state
  void emitLoadedState() {
    emit(state.toLoadedState());
  }

  /// Emits a processing/In Submit state. Use this to show processing message if any
  void emitProcessingState(
      {double progress = 0.0, String message = "Processing"}) {
    emit(state.toSubmittingState(statusMessage: message, progress: progress));
  }
}
