// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [
    search,
    browser1,
    browser2,
    statusOn,
    statusOff,
  ];

  static const search = 'cari';
  static const browser1 = 'buka';
  static const browser2 = 'pergi ke';
  static const statusOn = 'hidupkan';
  static const statusOff = 'matikan';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.search)) {
      final body = _getTextAfterCommand(text: text, command: Command.search);

      googleSeacrh(body: body!);
    } else if (text.contains(Command.browser1)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser1);

      openLink(url: url!);
    } else if (text.contains(Command.browser2)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);

      openLink(url: url!);
    } else if (text.contains(Command.statusOn)) {
      final deviceData =
          _getTextAfterCommand(text: text, command: Command.statusOn);
      onDev(url: deviceData!);
    } else if (text.contains(Command.statusOff)) {
      final deviceData =
          _getTextAfterCommand(text: text, command: Command.statusOff);
      offDev(url: deviceData!);
    }
  }

  static String? _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  // on func
  static Future onDev({
    required String url,
  }) async {
    final database = FirebaseDatabase.instance.ref();

    if (url == 'lampu pertama') {
      await database.child("lamp1").set(true);
    } else if (url == 'lampu kedua') {
      await database.child("lamp2").set(true);
    } else if (url == 'soket pertama') {
      await database.child("soket1").set(true);
    } else if (url == 'soket kedua') {
      await database.child("soket2").set(true);
    }
  }
  // end on func

  // off func
  static Future offDev({
    required String url,
  }) async {
    final database = FirebaseDatabase.instance.ref();

    if (url == 'lampu pertama') {
      await database.child("lamp1").set(false);
    } else if (url == 'lampu kedua') {
      await database.child("lamp2").set(false);
    } else if (url == 'soket pertama') {
      await database.child("soket1").set(false);
    } else if (url == 'soket kedua') {
      await database.child("soket2").set(false);
    }
  }
  // end off func

  static Future openLink({
    required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  static Future googleSeacrh({
    required String body,
  }) async {
    final url = 'https://google.com/search?q=$body';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    }
  }
}
