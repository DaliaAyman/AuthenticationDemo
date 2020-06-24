
import 'package:domain/domain_index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/presentation_index.dart';

void main(){
  group('LoginEvent', (){
    group('LoginButtonPressed', () { 
      test('props are [userEntity]', (){
        expect(LoginButtonPressed(UserEntity('email', 'password')).props, [UserEntity('email', 'password')]);
      });
      
      test('toString is LoginButtonPressed [email: email, password: password', (){
        expect(LoginButtonPressed(UserEntity('email', 'password')).toString(), 'LoginButtonPressed [userEntity]');
      });
    });
  });
}