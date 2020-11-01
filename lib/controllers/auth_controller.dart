import 'package:codechallenge/views/onboarding_view.dart';
import 'package:codechallenge/views/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<Widget> checkLoginUser() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) {
      return OnboardingView();
    } else {
      return TabView();
    }
  }
}
