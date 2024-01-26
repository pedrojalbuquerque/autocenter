import 'package:autocenter/app/models/user_model.dart';

abstract class UserService {
Future<UserModel?> register (String login, String password);
}