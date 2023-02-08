abstract class UserRepository {
  Future<void> register({
    required String email,
    required String password,
  });
}
