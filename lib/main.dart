import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_router.dart';

void main() async {
  // 这行代码的作用是确保 Flutter 的 widget 绑定已经初始化
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// 获取router
    final appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.router,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(useMaterial3: true),
    );
  }
}
