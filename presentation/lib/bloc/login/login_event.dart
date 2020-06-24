import 'package:domain/domain_index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent{
  final UserEntity userEntity;

  LoginButtonPressed(this.userEntity);

  @override
  List<Object> get props => [userEntity];

  @override
  String toString() {
    return "LoginButtonPressed [userEntity]";
  }
}