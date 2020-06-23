import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../../presentation_index.dart';
import 'index.dart';
import 'package:meta/meta.dart';

class LoginFormBloc extends FormBloc<String, String>{
  final LoginBloc loginBloc;

  LoginFormBloc(this.loginBloc) {
    addFieldBlocs(
      fieldBlocs: [
        email, password,
      ],
    );
  }

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required, FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  //When this method is called, the state of the form will be "FormBlocSubmitting"
  @override
  void onSubmitting() async {
    loginBloc.add(LoginButtonPressed(email: email.value, password: password.value));
    emitSuccess();

//    if (loginSuccess) {
//      emitSuccess();
//    } else {
//      emitFailure(failureResponse: 'Error onSubmitting');
//    }

  }

  @override
  Future<void> close() {
    email.close();
    password.close();
    return super.close();
  }

}