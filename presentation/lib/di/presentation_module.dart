import 'package:common/common.dart';
import 'package:domain/domain_index.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/presentation_index.dart';

class PresentationModule extends BaseDIModule{

  @override
  void configure(GetIt getIt) => getIt
      ..registerFactory(() => LoginBloc(getIt<UserRepository>(), getIt<AuthenticationBloc>()))
      ..registerFactory(() => LoginFormBloc())
      ..registerFactory(() => AuthenticationBloc(getIt<UserRepository>()));

}