import 'package:common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:domain/domain_index.dart';
import 'package:data/data_index.dart';
import 'package:remote/remote_index.dart';

class RemoteModule extends BaseDIModule{

  @override
  void configure(GetIt getIt) => getIt
      ..registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImp());
}