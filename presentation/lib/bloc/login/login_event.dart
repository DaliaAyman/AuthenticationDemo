import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent{
  final String email;
  final String password;

  LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return "LoginButtonPressed [email: $email, password: $password]";
  }
}