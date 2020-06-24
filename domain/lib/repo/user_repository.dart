import 'package:domain/domain_index.dart';

abstract class UserRepository{
  Future<String> authenticate(UserEntity userEntity);
  Future<bool> hasToken();
  Future<void> persistToken(String token);
  Future<void> deleteToken();
}