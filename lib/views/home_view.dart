import 'package:codechallenge/controllers/user_controller.dart';
import 'package:codechallenge/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeView extends StatelessWidget {
  final UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (_) => _checkOrientation(context),
      ),
    );
  }

  Widget _checkOrientation(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return SafeArea(
            child: Row(
              children: [_profile(), _btn()],
            ),
          );
        } else {
          return Column(
            children: [_profile(), _btn()],
          );
        }
      },
    );
  }

  Widget _profile() {
    return Flexible(
      flex: 1,
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  user.picture,
                  fit: BoxFit.cover,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                user.name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                user.gitUrl,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.0))),
      ),
    );
  }

  Widget _btn() {
    return Flexible(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _currentLocation(),
              SizedBox(
                height: 20.0,
              ),
              BtnPrimary(
                title: 'View my Location',
                onPressed: () {
                  user.getMyLocation();
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              BtnDanger(
                title: 'Logout',
                onPressed: () {
                  user.logoutService();
                },
              )
            ],
          ),
        ));
  }

  Widget _currentLocation() {
    if (user.lat == 0.0) {
      return Container();
    } else {
      return Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Latitube',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Longitude',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
          ]),
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.lat.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.lng.toString())),
          ]),
        ],
      );
    }
  }
}
