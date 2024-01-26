import 'package:autocenter/app/core/modules/auto_center_module.dart';
import 'package:autocenter/app/modules/auth/login/login_controller.dart';
import 'package:autocenter/app/modules/auth/login/login_page.dart';
import 'package:autocenter/app/modules/auth/register/register_controller.dart';
import 'package:autocenter/app/modules/auth/register/register_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends AutoCenterModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (_) => LoginController(),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(userService: context.read(),),
            ),
          ],
          routers: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}
