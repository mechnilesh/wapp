import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wapp/env/api_key.dart';
import 'package:provider/provider.dart';
import 'package:wapp/view_model/auth_state_check.dart';
import 'package:wapp/view_model/auth_view_model.dart';
import 'view_model/theme/theme_view_model.dart';
import 'view_model/weather_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await ApiKey().loadApiKey();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
    ],
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(builder: (context, theme, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.themeData,
        locale: theme.locale,
        home: const AuthStateCheck(),
      );
    });
  }
}
