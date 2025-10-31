import 'package:flutter/material.dart';
import '../presentation/screens/login_screen/login_screen.dart';
import '../presentation/screens/register_screen/register_screen.dart';
import '../presentation/screens/welcome_screen/welcome_screen.dart';
import '../presentation/screens/home_screen/home_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';
  static const String loginScreen = '/presentation/screens/login_screen';
  static const String initialRoute = '/';
  static const String registerScreen = '/presentation/screens/register_screen';
  static const String welcomeScreen = '/welcome_screen';

  static Map<String, WidgetBuilder> get routes => {
    homeScreen: (context) => const HomeScreen(),
    loginScreen: (context) => LoginScreen(),
    initialRoute: (context) => WelcomeScreen(),
    registerScreen: (context) => RegisterScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
  };
}
