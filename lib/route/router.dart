import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vici_technical_test/features/register/presentation/pages/register_page.dart';

import '../common/constants/router_constants.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/home/home_screen.dart';
import '../features/login/presentation/pages/login_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteName.loginRoute:
          return const LoginScreen();
        case RouteName.homeRoute:
          return const HomeScreen();
        case RouteName.registerRoute:
          return const RegisterPage();
        case RouteName.cartRoute:
          return const CartPage();

        default:
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
      }
    });
  }
}
