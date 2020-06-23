
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/presentation_index.dart';

void main(){
  group('LoginEvent', (){
    group('LoginButtonPressed', () { 
      test('props are [email, password]', (){
        expect(LoginButtonPressed(email: 'email', password: 'password').props, ['email', 'password']);
      });
      
      test('toString is LoginButtonPressed [email: email, password: password', (){
        expect(LoginButtonPressed(email: 'email', password: 'password').toString(), 'LoginButtonPressed [email: email, password: password]');
      });
    });
  });
}