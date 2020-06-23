import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:domain/domain_index.dart';
import '../../presentation_index.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
    : assert(userRepository != null);

  @override
  get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    try{
      if(event is AuthenticationStarted){
        final bool hasToken = await userRepository.hasToken();

        if(hasToken){
          yield AuthenticationSuccess();
        }else{
          yield AuthenticationFailure();
        }
      }
      if(event is AuthenticationLoggedIn){
        yield AuthenticationInProgress();
        print("AuthenticationInProgress");
        await userRepository.persistToken(event.token);
        print("AuthenticationInProgress persistToken");
        yield AuthenticationSuccess();
      }
      if(event is AuthenticationLoggedOut){
        yield AuthenticationInProgress();
        await userRepository.deleteToken();
        yield AuthenticationFailure();
      }
    }catch(e){
      print(e);
    }
  }
}