import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain_index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/presentation_index.dart';

class MockUserRepository extends Mock implements UserRepository{}

void main(){
  AuthenticationBloc authenticationBloc;
  MockUserRepository mockUserRepository;

  setUp((){
    mockUserRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: mockUserRepository);
  });

  tearDown((){
    authenticationBloc?.close();
  });

  test('throws AssertionError when userRepository is null', () {
    expect(
          () => AuthenticationBloc(userRepository: null),
      throwsAssertionError,
    );
  });

  test('initial state is correct', (){
    expect(authenticationBloc.initialState, AuthenticationInitial());
  });

  test('close does not emit new states', (){
    expectLater(authenticationBloc, emitsInOrder([
      AuthenticationInitial(), emitsDone
    ]));
    authenticationBloc.close();
  });

  group('AppStarted', () {
    blocTest('emits [unauthenticated] for invalid token',
        build: () async {
          when(mockUserRepository.hasToken())
              .thenAnswer((_) => Future.value(false));
          return authenticationBloc;
        },
        act: (authenticationBloc) => authenticationBloc.add(AuthenticationStarted()),
        expect: [
          AuthenticationFailure(),
        ]
    );

    blocTest('emits [authenticated] for valid token', 
        build: () async{
          when(mockUserRepository.hasToken())
              .thenAnswer((_) => Future.value(true));
          return authenticationBloc;
        },
        act: (authenticationBloc) => authenticationBloc.add(AuthenticationStarted()),
        expect: [
          AuthenticationSuccess(),
        ]
    );
  });

  group('LoggedIn', () { 
    blocTest('emits [loading, authenticated] when token is persisted',
        build: () async{
          return authenticationBloc;
        },
        act: (authenticationBloc) => authenticationBloc.add(AuthenticationLoggedIn(token: 'token')),
        expect: [
          AuthenticationInProgress(), AuthenticationSuccess()
        ]);
    
    blocTest('emits [loading, unauthenticated] when token is deleted',
        build: () async{
          return authenticationBloc;
        },
        act: (authenticationBloc) => authenticationBloc.add(AuthenticationLoggedOut()),
        expect: [
          AuthenticationInProgress(), AuthenticationFailure()
        ]
        );
  });


}