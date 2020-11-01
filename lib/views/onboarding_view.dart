import 'package:codechallenge/controllers/login_controller.dart';
import 'package:codechallenge/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends StatelessWidget {
  final LoginController login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [logoWidget(), loginWidget()],
      ),
    );
  }

  Widget logoWidget() {
    return Flexible(
        flex: 1,
        child: Center(
          child: Image.network(
            'https://www.tinypulse.com/hs-fs/hubfs/best_companies_helloworld_1.pngw300.png?width=400&name=best_companies_helloworld_1.pngw300.png',
            width: 200,
          ),
        ));
  }

  Widget loginWidget() {
    return Flexible(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: BtnPrimary(
            title: 'Continue with Github',
            onPressed: () {
              login.login();
            },
          ),
        ));
  }
}
