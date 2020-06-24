import 'package:domain/domain_index.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../../presentation_index.dart';
import 'index.dart';

class LoginFormBloc extends FormBloc<UserEntity, String>{

  LoginFormBloc() {
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
    print("emitSuccess onSubmitting");
    emitSuccess(successResponse: UserEntity(email.value, password.value));

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