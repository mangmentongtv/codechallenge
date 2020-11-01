import 'package:codechallenge/controllers/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabView extends StatelessWidget {
  final TabsController tabs = Get.put(TabsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: tabs.currentTab,
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mood_rounded), label: 'Weather')
              ],
              currentIndex: tabs.currentIndex.value,
              selectedItemColor: Colors.lightBlue,
              onTap: tabs.changePage),
        ));
  }
}
