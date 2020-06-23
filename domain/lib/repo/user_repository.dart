
abstract class UserRepository{
  Future<String> authenticate(String email, String password);
  Future<bool> hasToken();
  Future<void> persistToken(String token);
  Future<void> deleteToken();
}