import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../common/result.dart';
import '../data/errors/app_error.dart';
import '../di/register_dependencies.dart';
import 'home/add_employee_page.dart';
import 'home/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Future<Result<void>> _initRef;

  @override
  void initState() {
    super.initState();
    _initRef = _init();
  }

  Future<Result<void>> _init() async {
    try {
      await Hive.initFlutter();
      registerDependencies();
      await ScreenUtil.ensureScreenSize();
      
      return Result.success();
    } on Exception {
      return Result.failure(AppError());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initRef,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ScreenUtil.init(
              context,
              designSize: const Size(428, 926)
            );
            FlutterNativeSplash.remove();
            return MaterialApp(
              initialRoute: HomePage.routeName,
              routes: {
               AddEmployeePage.routeName:(context) => const AddEmployeePage(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const HomePage(),
            );
          }
          return const SizedBox();
        });
  }
}
