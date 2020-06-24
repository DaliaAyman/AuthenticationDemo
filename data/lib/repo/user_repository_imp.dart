import 'package:domain/domain_index.dart';
import 'package:data/data_index.dart';
class UserRepositoryImp extends UserRepository{

  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp(this.userRemoteDataSource);

  @override
  Future<String> authenticate(UserEntity userEntity) {
    return userRemoteDataSource.authenticate(userEntity);
  }

  @override
  Future<bool> hasToken() {
    return userRemoteDataSource.hasToken();
  }

  @override
  Future<void> persistToken(String token) {
    return userRemoteDataSource.persistToken(token);
  }

  @override
  Future<void> deleteToken() {
    return userRemoteDataSource.deleteToken();
  }

}