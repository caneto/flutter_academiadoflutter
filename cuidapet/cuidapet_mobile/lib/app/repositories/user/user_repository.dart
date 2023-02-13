import '../../models/confirm_login_model.dart';
import '../../models/social_network_model.dart';
import '../../models/user_model.dart';

abstract class UserRepository {
  Future<void> register({
    required String email,
    required String password,
  });
  Future<String> login({required String email, required String password});
  Future<ConfirmLoginModel> confirmLogin();
  Future<UserModel> getLoggedUser();
  Future<String> loginSocial(SocialNetworkModel model);
}
