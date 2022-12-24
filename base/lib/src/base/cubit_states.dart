/* Represents a Loading state */

import 'cubit_state.dart';
import 'errors.dart';

///Represents a Loading in progress state
class CubitLoadingState<T> extends CubitState<T> {
  /* The loading status message that is required */
  String loadingStatus;

  double progress;

  CubitLoadingState(T current,
      {required this.loadingStatus, this.progress = 0.0})
      : super(current, isLoading: true);
}

///Represents a Loaded state
class CubitLoadedState<T> extends CubitState<T> {
  CubitLoadedState(T current) : super(current);
}

///Represents a Processing/submitting state
class CubitSubmittingState<T> extends CubitState<T> {
  String submittingMessage;

  double progress;

  CubitSubmittingState(T current,
      {required this.submittingMessage, this.progress = 0.0})
      : super(current, isSubmitting: true);
}

///Represents a Success Processing state
class CubitSuccessResponseState<T, Success> extends CubitState<T> {
  Success? successResponse;

  CubitSuccessResponseState(T current, this.successResponse)
      : super(current, isSuccess: true);
}

///Represents a Failure Processing state
class CubitFailureResponseState<T, Failure> extends CubitState<T> {
  Failure? failureResponse;
  CubitFailureResponseState(T current, this.failureResponse)
      : super(current, isFailure: true);
}

///Represnets a Failure state with validaiton errors
class CubitFailureState<T> extends CubitState<T> {
  /// Validation failure message
  String failureMessage;

  /// Individual field errors. The individual blocs will have errorMessagae which
  /// will be shown againt them. This can be used to handle the errors in non-bloc fields
  ///
  List<ValidationError>? errors;

  CubitFailureState(T current, this.failureMessage, {this.errors})
      : super(current, isFailure: true);
}
