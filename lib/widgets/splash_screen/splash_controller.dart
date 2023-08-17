import 'dart:async';
import 'package:e_commerce/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_screen/auth_screen.dart';
import '../../common/bottom_bar.dart';
import '../../features/admin/screens/admin_screen.dart';


class SplashScreenController {
  void SplashTime(BuildContext context) {
    Timer(
        const Duration(milliseconds: 4000),
            () =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (
                    context) => Provider.of<UserProvider>(context).user.token.isNotEmpty
                    ? Provider.of<UserProvider>(context).user.type == 'user'
                    ? const BottomBar()
                    : const AdminScreen()
                    : const AuthScreen(),
                )
            ));
  }

}