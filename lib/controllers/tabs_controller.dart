import 'package:codechallenge/views/home_view.dart';
import 'package:codechallenge/views/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TabsController extends GetxController {
  static TabsController get to => Get.find();

  final currentIndex = 0.obs;

  List<Widget> pages = [HomeView(), WeatherView()];

  Widget get currentTab => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
