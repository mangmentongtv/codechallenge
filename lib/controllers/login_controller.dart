import 'package:codechallenge/views/tab_view.dart';
import 'package:codechallenge/utils/constants.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool loading = false;

  Future<void> login() async {
    loading = true;

    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: 'https://$AUTH0_DOMAIN',
        scopes: ['openid', 'profile', 'offline_access'],
      ));

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      Get.offAll(TabView());
    } catch (e) {
      loading = false;
      Get.snackbar('Error', 'An error occur. Please try again later');
    }
  }
}
