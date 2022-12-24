import 'form_field_base.dart';

class InputFieldValidators {
  /// Required field validator function that validates a value and returns
  /// the corresponding error message if it is NULL
  static InputFieldValidator<T> required<T>(String errorMessage) {
    return ((value) async {
      if (value == null || value.toString().isEmpty) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> email(String errorMessage) {
    return ((value) async {
      if (value == null ||
          !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<int> minimum(int minimum, String errorMessage) {
    return ((value) async {
      if (value == null || value < minimum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> minimumString(
      int minimum, String errorMessage) {
    return ((value) async {
      if (value == null || value.length < minimum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> maximumString(
      int maximum, String errorMessage) {
    return ((value) async {
      if (value == null || value.length > maximum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  ///Just compose a function which returns the Error Message if any
  ///of the validator returns an string message
  static InputFieldValidator<T> compose<T>(
      List<InputFieldValidator<T>> validators) {
    return (valueCandidate) async {
      for (var validator in validators) {
        final errMsg = await validator.call(valueCandidate);
        if (errMsg != null) {
          //There is an error Message. return that
          return errMsg;
        }
      }
      //No error
      return null;
    };
  }
}
