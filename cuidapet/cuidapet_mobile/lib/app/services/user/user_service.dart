
import '../../models/social_login_type.dart';

abstract class UserService {
  Future<void> register({required String email, required String password});
  Future<void> login({required String email, required String password});
  Future<void> socialLogin(SocialLoginType type);
}
