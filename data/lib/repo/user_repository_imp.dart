import 'package:domain/domain_index.dart';

class UserRepositoryImp extends UserRepository{

  @override
  Future<String> authenticate(String email, String password) {
    return Future.value("token");
  }

  @override
  Future<bool> hasToken() {
    return Future.value(true);
  }

  @override
  Future<void> persistToken(String token) {
    return Future.value();
  }

  @override
  Future<void> deleteToken() {
    return Future.value();
  }

}