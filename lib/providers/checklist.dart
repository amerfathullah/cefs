import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './equipment.dart';

enum ShiftDay {
  A,
  B,
  C,
  D,
}

enum ShiftNight {
  A,
  B,
  C,
  D,
}

class Checklist with ChangeNotifier {
  final String id;
  final String foamTender;
  final String regNo;
  final DateTime dateTime;
  ShiftDay shiftDay;
  ShiftNight shiftNight;
  final double foamCapacity;
  final double waterCapacity;
  final int c1e1day;
  final int c1e1night;
  final int c1e2day;
  final int c1e2night;
  final int c1e3day;
  final int c1e3night;
  final int c1e4day;
  final int c1e4night;
  final int c2e1day;
  final int c2e1night;
  final int c2e2day;
  final int c2e2night;
  final String inspectNameDay;
  // final String inspectSignDay;
  final String inspectNameNight;
  // final String inspectSignNight;
  final String watchNameDay;
  // final String watchSignDay;
  final String watchNameNight;
  // final String watchSignNight;

  Checklist({
    this.id,
    this.foamTender,
    this.regNo,
    this.dateTime,
    this.shiftDay,
    this.shiftNight,
    this.foamCapacity,
    this.waterCapacity,
    this.c1e1day,
    this.c1e1night,
    this.c1e2day,
    this.c1e2night,
    this.c1e3day,
    this.c1e3night,
    this.c1e4day,
    this.c1e4night,
    this.c2e1day,
    this.c2e1night,
    this.c2e2day,
    this.c2e2night,
    this.inspectNameDay,
    // this.inspectSignDay,
    this.inspectNameNight,
    // this.inspectSignNight,
    this.watchNameDay,
    // this.watchSignDay,
    this.watchNameNight,
    // this.watchSignNight,
  });

  // void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  // Future<void> toggleFavoriteStatus(String token, String userId) async {
  //   final oldStatus = isFavorite;
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  //   final url = Uri.parse(
  //       'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$token');
  //   try {
  //     final response = await http.put(url,
  //         body: json.encode(
  //           isFavorite,
  //         ));
  //     if (response.statusCode >= 400) {
  //       _setFavValue(oldStatus);
  //     }
  //   } catch (e) {
  //     _setFavValue(oldStatus);
  //   }
  // }
}
