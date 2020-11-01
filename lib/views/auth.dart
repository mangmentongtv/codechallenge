import 'package:codechallenge/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkLoginUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
