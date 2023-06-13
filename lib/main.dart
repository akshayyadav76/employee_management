import 'package:employee_management/presentation/app.dart';
import 'package:flutter/material.dart';


import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';

import 'data/table/employee_table.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Hive.initFlutter();
  // registerDependencies();
  Hive.registerAdapter(EmployeeTableAdapter());
  runApp(const App());
}

