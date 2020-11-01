import 'dart:convert';
import 'package:codechallenge/views/onboarding_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:codechallenge/utils/constants.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String name = '';
  String picture = '';
  String gitUrl = '';
  double lat = 0.0;
  double lng = 0.0;

  String datetime = DateFormat.yMd().format(DateTime.now());
  String temp = '';
  String desc = '';
  String main = '';
  String pressure = '';
  String humidity = '';

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseID(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);
      name = profile['name'];
      picture = profile['picture'];
      gitUrl = 'https://github.com/' + profile['nickname'];
      update();
    } catch (e) {
      Get.snackbar('Error', 'An error occur. Please try again later');
      logoutService();
    }
  }

  Future<void> logoutService() async {
    await secureStorage.delete(key: 'refresh_token');
    Get.offAll(OnboardingView());
  }

  Map<String, dynamic> parseID(String tokenID) {
    final parts = tokenID.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  void getMyLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lng = position.longitude;
      getWeather(lat, lng);
      update();
    } else {
      Get.snackbar(
          'Error', 'Please enable the permission in you phone settings');
    }
  }

  void getWeather(lat, lng) async {
    var params = '?lat=' +
        lat.toString() +
        '&lon=' +
        lng.toString() +
        '&appid=' +
        WEATHER_KEY;
    final response = await http.get(WEATHER_URL + 'weather' + params);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      temp = data['main']['temp'].toString();
      desc = data['weather'][0]['description'];
      main = data['weather'][0]['main'];
      pressure = data['main']['pressure'].toString();
      humidity = data['main']['humidity'].toString();

      var date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
      var formattedDate = DateFormat.yMd().format(date);
      datetime = formattedDate;

      update();
    }
  }
}
