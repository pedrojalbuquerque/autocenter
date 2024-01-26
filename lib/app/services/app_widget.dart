import 'package:autocenter/app/core/database/sqlite_adm_connection.dart';
import 'package:autocenter/app/core/ui/auto_center_ui_config.dart';
import 'package:autocenter/app/modules/auth/auth_module.dart';
import 'package:autocenter/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var sqliteAdm = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.removeObserver(sqliteAdm);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(sqliteAdm);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Auto Center App",
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      theme: AutoCenterUiConfig.theme,
      routes: {...AuthModule().routers},
      home: const SplashPage(),
    );
  }
}
