import 'package:codechallenge/controllers/user_controller.dart';
import 'package:codechallenge/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherView extends StatelessWidget {
  final UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text('Weather',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: GetBuilder<UserController>(
        builder: (_) => _checkPermission(context),
      ),
    );
  }

  Widget _checkPermission(context) {
    if (user.lat == 0.0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: BtnPrimary(
            title: 'Get Current Location',
            onPressed: () {
              user.getMyLocation();
            },
          ),
        ),
      );
    }

    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _landscapeTbl();
        } else {
          return _portraitTbl();
        }
      },
    ));
  }

  Widget _portraitTbl() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Date (mm/dd/yyyy)',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Temperature (F)',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
          ]),
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.datetime.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.temp.toString())),
          ]),
        ],
      ),
    );
  }

  Widget _landscapeTbl() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Date (mm/dd/yyyy)',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Temperature (F)',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Description',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Main',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Pressure',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Humidity',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
          ]),
          TableRow(children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.datetime.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.temp.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.desc.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.main.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.pressure.toString())),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(user.humidity.toString())),
          ]),
        ],
      ),
    );
  }
}
