
import 'package:data/data_index.dart';
import 'package:domain/domain_index.dart';

class UserRemoteDataSourceImp extends UserRemoteDataSource{

  @override
  Future<String> authenticate(UserEntity userEntity) {
    //TODO dummy authentication replace by actual server authentication
    if(userEntity.email == "d@test.com")
      return Future.value("token");
    else
      return null;
  }

  @override
  Future<void> deleteToken() {
    return Future.value();
  }

  @override
  Future<bool> hasToken() {
    return Future.value(true);
  }

  @override
  Future<void> persistToken(String token) {
    if(token != null)
      return Future.value();
    else
      throw Exception("Null token");
  }



}