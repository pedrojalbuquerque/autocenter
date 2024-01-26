import 'package:autocenter/app/models/user_model.dart';
import 'package:autocenter/app/repositories/user/user_repository.dart';
import 'package:autocenter/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserModel?> register(String login, String password) =>
      _userRepository.register(login, password);
}
