// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:listen_me/screen/speach.dart';
import 'package:listen_me/services/greetings.dart';
import 'package:listen_me/theme.dart';
import 'package:listen_me/widgets/weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  late bool? isSwitchlLamp1 = false;
  late bool? isSwitchlLamp2 = false;
  late bool? isSwitchlSock1 = false;
  late bool? isSwitchlSock2 = false;

  void _activeListeners() {
    database.child("lamp1").onValue.listen((event) {
      final lamp1Data = event.snapshot.value;
      setState(() {
        isSwitchlLamp1 = (lamp1Data as bool?)!;
      });
    });

    database.child("lamp2").onValue.listen((event) {
      final lamp2Data = event.snapshot.value;
      setState(() {
        isSwitchlLamp2 = (lamp2Data as bool?)!;
      });
    });

    database.child("soket1").onValue.listen((event) {
      final soket1data = event.snapshot.value;
      setState(() {
        isSwitchlSock1 = (soket1data as bool?)!;
      });
    });

    database.child("soket2").onValue.listen((event) {
      final soket2data = event.snapshot.value;
      setState(() {
        isSwitchlSock2 = (soket2data as bool?)!;
      });
    });
  }

  onChangeMethode1(bool newValue1) {
    setState(() {
      database.child("lamp1").set(newValue1);
    });
  }

  onChangeMethode2(bool newValue2) {
    setState(() {
      database.child("lamp2").set(newValue2);
    });
  }

  onChangeMethode3(bool newValue3) {
    setState(() {
      database.child("soket1").set(newValue3);
    });
  }

  onChangeMethode4(bool newValue4) {
    setState(() {
      database.child("soket2").set(newValue4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.speaker_phone),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SpeechPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting(),
                style: titleTextStyle,
              ),
              Text(
                "Ayo, kelola rumah pintar Anda",
                style: subTitleTextStyle,
              ),
              // WeatherWidget()
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                    color: bgPrimaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: WeatherWidget(),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  cardDevice(isSwitchlLamp1!, "Lampu 1", Icons.lightbulb,
                      onChangeMethode1),
                  cardDevice(isSwitchlLamp2!, "Lampu 2", Icons.lightbulb,
                      onChangeMethode2),
                  cardDevice(isSwitchlSock1!, "Soket 1",
                      Icons.electrical_services, onChangeMethode3),
                  cardDevice(isSwitchlSock2!, "Soket 2",
                      Icons.electrical_services, onChangeMethode4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container cardDevice(bool deviceStatus, String deviceName, IconData iconname,
      Function onChangeMethode) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: deviceStatus == true ? iconActive : iconInactive,
            child: Icon(
              iconname,
              color: deviceStatus == true ? bgPrimaryColor : bgSecondaryColor,
            ),
          ),
          Text(
            deviceName,
            style: deviceTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deviceStatus == true ? "ON" : "OFF",
                style: deviceStatusTextStyle,
              ),
              Switch(
                value: deviceStatus,
                onChanged: (value) {
                  onChangeMethode(value);
                },
                activeTrackColor: const Color(0xff92E3F5),
                activeColor: const Color(0xffFFFFFF),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          color: deviceStatus == true ? bgPrimaryColor : bgSecondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}
