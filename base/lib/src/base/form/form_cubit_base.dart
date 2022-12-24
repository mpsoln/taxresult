import 'package:base/src/base/cubit_base.dart';
import 'package:base/src/base/cubit_state.dart';
import 'package:base/src/base/errors.dart';

import 'form_field_base.dart';

/// Base class for all Cubit items that has a form/submit method
class FormCubitBase<T> extends CubitBase<T> {
  FormCubitBase(CubitState<T> initialState) : super(initialState);

  /// Individual blocs inside this form. Each bloc may represent/correspond to an individual UI elment
  List<FormFieldBloc> blocs = [];

  /// Validates the bloc and returns the errors
  /// This can be customiezd by derived classes if required
  Future<List<ValidationError>> validate() async {
    List<ValidationError> errors = [];
    for (int i = 0; i < blocs.length; ++i) {
      var bloc = blocs[i];
      //Clear the validation error first
      bloc.clearError();
      //Validate each bloc..

      if (!await bloc.validate()) {
        //There is a validation failure in one bloc..
        //so set the errir
        //Add the error to the errors list..

        errors.add(ValidationError(
            error: bloc.state.current.error as String,
            fieldName: bloc.state.current.fieldName));
      }
    }

    return errors;
  }

  @override
  void dispose() {
    for (FormFieldBloc<dynamic, FormFieldState<dynamic>> b in blocs) {
      b.close();
    }
    super.dispose();
  }
}
