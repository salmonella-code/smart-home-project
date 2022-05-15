// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listen_me/screen/speach.dart';
import 'package:listen_me/services/greetings.dart';
import 'package:listen_me/theme.dart';
import 'package:listen_me/widgets/weather.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: bgSecondaryColor,
      statusBarColor: bgSecondaryColor));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listen Me',
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: backgroundColor,
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  bool? isSwitchlLamp1 = false;
  bool? isSwitchlLamp2 = false;
  bool? isSwitchlSock1 = false;
  bool? isSwitchlSock2 = false;

  onChangeMethode1(bool newValue1) {
    setState(() {
      isSwitchlLamp1 = newValue1;
    });
  }

  onChangeMethode2(bool newValue2) {
    setState(() {
      isSwitchlLamp2 = newValue2;
    });
  }

  onChangeMethode3(bool newValue3) {
    setState(() {
      isSwitchlSock1 = newValue3;
    });
  }

  onChangeMethode4(bool newValue4) {
    setState(() {
      isSwitchlSock2 = newValue4;
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
