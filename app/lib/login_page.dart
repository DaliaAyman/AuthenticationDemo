import 'package:app/success_screen.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:presentation/bloc/index.dart';
import 'package:domain/domain_index.dart';
import 'loading_dialog.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;
  LoginFormBloc loginFormBloc;

  UserEntity userEntity;

  void initBloc() {
    loginBloc = Injector.of(context).inject<LoginBloc>();
    loginFormBloc = Injector.of(context).inject<LoginFormBloc>();
  }

  @override
  Widget build(BuildContext context) {
    initBloc();

    return BlocProvider(
      create: (context) => loginFormBloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: FormBlocListener<LoginFormBloc, UserEntity, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);

                userEntity = state.successResponse;

                if (state is FormBlocSuccess) {
                  loginBloc.add(LoginButtonPressed(userEntity));
                }
//                Navigator.of(context).pushReplacement(
//                    MaterialPageRoute(builder: (_) => SuccessScreen()));
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: BlocListener(
                        bloc: loginBloc,
                        listener: (BuildContext context, LoginState state) {
                          if (state is LoginInitial) {
                            Toast.show('Login Success', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          } else if (state is LoginFailure) {
                            Toast.show('Login Failure', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                        },
                        child: Container(),
                      ),
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: loginFormBloc.email,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: loginFormBloc.password,
                      suffixButton: SuffixButton.obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: loginFormBloc.submit,
                        child: Text('LOGIN'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    loginFormBloc.close();
    super.dispose();
  }
}
