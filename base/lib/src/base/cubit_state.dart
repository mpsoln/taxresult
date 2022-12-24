/* Represents a Cubit base State */

import 'cubit_states.dart';
import 'errors.dart';

//typedef CubitFailureResponseState<T, String> SubmissionFailure<T>();

class CubitState<T> {
  /* The current state*/
  late T current;

  late bool isSubmitting;

  late bool isLoading;

  late bool isFailure;

  late bool isSuccess;

  CubitState(this.current,
      {this.isSubmitting = false,
      this.isLoading = false,
      this.isFailure = false,
      this.isSuccess = false});

  /// Returns a new LoadingState() with the current state values
  CubitLoadingState<T> toLoadingState(
      {double progress = 0.0, required String loadingStatus}) {
    return CubitLoadingState<T>(current,
        loadingStatus: loadingStatus, progress: progress);
  }

  /// Returns a new LoadedState() with the current state values
  CubitLoadedState<T> toLoadedState() {
    return CubitLoadedState(current);
  }

  /// Returns a new SubmittingState() with the current state values
  CubitSubmittingState<T> toSubmittingState(
      {double progress = 0.0, required String statusMessage}) {
    return CubitSubmittingState(current,
        submittingMessage: statusMessage, progress: progress);
  }

  /// Returns a new SuccessState() with the current state values
  CubitSuccessResponseState<T, SuccessResponse> toSuccessState<SuccessResponse>(
      SuccessResponse response) {
    return CubitSuccessResponseState(current, response);
  }

  /// Returns a new Failure() with the current state values and the validation error
  /// message and errors
  CubitFailureState<T> toFailureState(
      String failureMessage, List<ValidationError>? errors) {
    return CubitFailureState(current, failureMessage, errors: errors);
  }
}
