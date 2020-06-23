import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/presentation_index.dart';
import 'package:domain/domain_index.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  MockUserRepository mockUserRepository;
  MockAuthenticationBloc mockAuthenticationBloc;
  LoginBloc loginBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockAuthenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(mockUserRepository, mockAuthenticationBloc);
  });

  tearDown(() {
    loginBloc.close();
    mockAuthenticationBloc.close();
  });

  test('throws AssertionError when userRepository is null', (){
    expect(() => LoginBloc(null, mockAuthenticationBloc), throwsAssertionError);
  });

  test('throws AssertionError when authenticationBloc is null', (){
    expect(() => LoginBloc(mockUserRepository, null), throwsAssertionError);
  });

  test('initial state is correct', () {
    expect(LoginInitial(), loginBloc.initialState);
  });

  test('close doesn\'t emit new states', () {
    expectLater(loginBloc, emitsInOrder(([LoginInitial(), emitsDone])));
    loginBloc.close();
  });

  group('LoginButtonPressed', () {
    blocTest('emits [LoginLoading, LoginInitial], and token on success',
        build: () async {
          when(mockUserRepository.authenticate("valid email", "valid password"))
              .thenAnswer((_) => Future.value("token"));

          return loginBloc;
        },
        act: (loginBloc) => loginBloc.add(
              LoginButtonPressed(
                  email: "valid email", password: "valid password"),
            ),
        expect: [LoginInProgress(), LoginInitial()],
        verify: (_) async {
          verify(mockAuthenticationBloc
                  .add(AuthenticationLoggedIn(token: 'token')))
              .called(1);
        });

    blocTest(
      'emits [LoginLoading, LoginFailure] on failure',
      build: () async {
        when(mockUserRepository.authenticate(
          'valid.username',
          'valid.password',
        )).thenThrow(Exception('login-error'));
        return loginBloc;
      },
      act: (loginBloc) => loginBloc.add(
        LoginButtonPressed(
          email: 'valid.username',
          password: 'valid.password',
        ),
      ),
      expect: [
        LoginInProgress(),
        LoginFailure(error: 'Exception: login-error'),
      ],
      verify: (_) async {
        verifyNever(mockAuthenticationBloc.add(any));
      },
    );
  });
}
