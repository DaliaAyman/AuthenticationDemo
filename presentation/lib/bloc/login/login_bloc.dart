import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../../presentation_index.dart';
import 'index.dart';
import 'package:domain/domain_index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository, this.authenticationBloc}) : assert(userRepository != null), assert(authenticationBloc != null);

  @override
  get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if(event is LoginButtonPressed){
      yield LoginInProgress();

      try{
        final token = await userRepository.authenticate(event.email, event.password);
        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginInitial();
      }catch(e){
        yield LoginFailure(error: e.toString());
      }
    }
  }
}