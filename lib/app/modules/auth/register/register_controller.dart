import 'package:autocenter/app/exception/auth_exception.dart';
import 'package:flutter/material.dart';

import 'package:autocenter/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String login, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(login, password);
      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar o usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
