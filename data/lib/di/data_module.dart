import 'package:common/common.dart';
import 'package:domain/domain_index.dart';
import 'package:get_it/get_it.dart';
import '../data_index.dart';

class DataModule extends BaseDIModule{

  @override
  void configure(GetIt getIt) => getIt
    ..registerFactory<UserRepository>(() => UserRepositoryImp(getIt<UserRemoteDataSource>()));

}