import 'package:autocenter/app/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> register(String login, String password);
}
