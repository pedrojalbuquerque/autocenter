import 'package:autocenter/app/core/database/sqllite_connection_factory.dart';
import 'package:autocenter/app/models/user_model.dart';
import 'package:autocenter/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SqlliteConnectionFactory _sqlliteConnectionFactory;

  UserRepositoryImpl({
    required SqlliteConnectionFactory sqlliteConnectionFactory,
  }) : _sqlliteConnectionFactory = sqlliteConnectionFactory;

  @override
  Future<UserModel?> register(String login, String password) async {
    final conn = await _sqlliteConnectionFactory.openConnection();
    final checkLogin = await conn.rawQuery('SELECT * FROM users WHERE login = "$login"');
    if(checkLogin.isNotEmpty){
      return null;
    }
    final registerId = await conn.insert('users', {'login': login, 'password': password});
    if(registerId == 0){
      return null;
    } else {
      return UserModel.fromMap({'id': registerId, 'login': login, 'password': password});
    }
  }
}
