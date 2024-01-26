import 'package:autocenter/app/core/database/sqllite_connection_factory.dart';
import 'package:autocenter/app/repositories/user/user_repository.dart';
import 'package:autocenter/app/repositories/user/user_repository_impl.dart';
import 'package:autocenter/app/services/app_widget.dart';
import 'package:autocenter/app/services/user/user_service.dart';
import 'package:autocenter/app/services/user/user_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqlliteConnectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            sqlliteConnectionFactory: context.read(),
          ),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(
            userRepository: context.read(),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
