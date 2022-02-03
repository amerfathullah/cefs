import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'checklist.dart';

class Checklists with ChangeNotifier {
  List<Checklist> _items = [];

  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  Checklists(this.authToken, this.userId, this._items);

  List<Checklist> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  // List<Checklist> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  Checklist findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetChecklists([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url = Uri.parse(
        'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/checklists.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // final favoriteResponse = await http.get(Uri.parse(
      //     'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken'));
      // final favoriteData = json.decode(favoriteResponse.body);
      var loadedShiftDay = null;
      var loadedShiftNight = null;
      final List<Checklist> loadedChecklists = [];
      extractedData.forEach((prodId, prodData) {
        if (prodData['shiftDay'] == 'ShiftDay.A') {
          loadedShiftDay = ShiftDay.A;
        } else if (prodData['shiftDay'] == 'ShiftDay.B') {
          loadedShiftDay = ShiftDay.B;
        } else if (prodData['shiftDay'] == 'ShiftDay.C') {
          loadedShiftDay = ShiftDay.C;
        } else if (prodData['shiftDay'] == 'ShiftDay.D') {
          loadedShiftDay = ShiftDay.D;
        } else {
          loadedShiftDay = null;
        }
        if (prodData['shiftNight'] == 'ShiftNight.A') {
          loadedShiftNight = ShiftNight.A;
        } else if (prodData['shiftNight'] == 'ShiftNight.B') {
          loadedShiftNight = ShiftNight.B;
        } else if (prodData['shiftNight'] == 'ShiftNight.C') {
          loadedShiftNight = ShiftNight.C;
        } else if (prodData['shiftNight'] == 'ShiftNight.D') {
          loadedShiftNight = ShiftNight.D;
        } else {
          loadedShiftNight = null;
        }
        loadedChecklists.add(
          Checklist(
            id: prodId,
            foamTender: prodData['foamTender'],
            regNo: prodData['regNo'],
            dateTime: DateTime.parse(prodData['dateTime']),
            shiftDay: loadedShiftDay,
            shiftNight: loadedShiftNight,
            foamCapacity: prodData['foamCapacity'],
            waterCapacity: prodData['waterCapacity'],
            c1e1day: prodData['c1e1day'],
            c1e1night: prodData['c1e1night'],
            c1e2day: prodData['c1e2day'],
            c1e2night: prodData['c1e2night'],
            c1e3day: prodData['c1e3day'],
            c1e3night: prodData['c1e3night'],
            c1e4day: prodData['c1e4day'],
            c1e4night: prodData['c1e4night'],
            c2e1day: prodData['c2e1day'],
            c2e1night: prodData['c2e1night'],
            c2e2day: prodData['c2e2day'],
            c2e2night: prodData['c2e2night'],
            inspectNameDay: prodData['inspectNameDay'],
            // inspectSignDay: prodData['inspectSignDay'],
            inspectNameNight: prodData['inspectNameNight'],
            // inspectSignNight: prodData['inspectSignNight'],
            watchNameDay: prodData['watchNameDay'],
            // watchSignDay: prodData['watchSignDay'],
            watchNameNight: prodData['watchNameNight'],
            // watchSignNight: prodData['watchSignNight'],
          ),
        );
      });
      _items = loadedChecklists;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addChecklist(Checklist checklist) async {
    final url = Uri.parse(
        'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/checklists.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'foamTender': checklist.foamTender,
            'regNo': checklist.regNo,
            'dateTime': DateTime.now().toIso8601String(),
            'shiftDay': checklist.shiftDay.toString(),
            'shiftNight': checklist.shiftNight.toString(),
            'foamCapacity': checklist.foamCapacity,
            'waterCapacity': checklist.waterCapacity,
            'c1e1day': checklist.c1e1day,
            'c1e1night': checklist.c1e1night,
            'c1e2day': checklist.c1e2day,
            'c1e2night': checklist.c1e2night,
            'c1e3day': checklist.c1e3day,
            'c1e3night': checklist.c1e3night,
            'c1e4day': checklist.c1e4day,
            'c1e4night': checklist.c1e4night,
            'c2e1day': checklist.c2e1day,
            'c2e1night': checklist.c2e1night,
            'c2e2day': checklist.c2e2day,
            'c2e2night': checklist.c2e2night,
            'inspectNameDay': checklist.inspectNameDay,
            // 'inspectSignDay': checklist.inspectSignDay,
            'inspectNameNight': checklist.inspectNameNight,
            // 'inspectSignNight': checklist.inspectSignNight,
            'watchNameDay': checklist.watchNameDay,
            // 'watchSignDay': checklist.watchSignDay,
            'watchNameNight': checklist.watchNameNight,
            // 'watchSignNight': checklist.watchSignNight,
            'creatorId': userId,
          },
        ),
      );
      final newChecklist = Checklist(
        id: json.decode(response.body)['name'],
        foamTender: checklist.foamTender,
        regNo: checklist.regNo,
        dateTime: checklist.dateTime,
        shiftDay: checklist.shiftDay,
        shiftNight: checklist.shiftNight,
        foamCapacity: checklist.foamCapacity,
        waterCapacity: checklist.waterCapacity,
        c1e1day: checklist.c1e1day,
        c1e1night: checklist.c1e1night,
        c1e2day: checklist.c1e2day,
        c1e2night: checklist.c1e2night,
        c1e3day: checklist.c1e3day,
        c1e3night: checklist.c1e3night,
        c1e4day: checklist.c1e4day,
        c1e4night: checklist.c1e4night,
        c2e1day: checklist.c2e1day,
        c2e1night: checklist.c2e1night,
        c2e2day: checklist.c2e2day,
        c2e2night: checklist.c2e2night,
        inspectNameDay: checklist.inspectNameDay,
        // inspectSignDay: checklist.inspectSignDay,
        inspectNameNight: checklist.inspectNameNight,
        // inspectSignNight: checklist.inspectSignNight,
        watchNameDay: checklist.watchNameDay,
        // watchSignDay: checklist.watchSignDay,
        watchNameNight: checklist.watchNameNight,
        // watchSignNight: checklist.watchSignNight,
      );
      _items.add(newChecklist);
      // _items.insert(0, newChecklist); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateChecklist(String id, Checklist newChecklist) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/checklists/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'foamTender': newChecklist.foamTender,
            'regNo': newChecklist.regNo,
            'shiftDay': newChecklist.shiftDay.toString(),
            'shiftNight': newChecklist.shiftNight.toString(),
            'foamCapacity': newChecklist.foamCapacity,
            'waterCapacity': newChecklist.waterCapacity,
            'c1e1day': newChecklist.c1e1day,
            'c1e1night': newChecklist.c1e1night,
            'c1e2day': newChecklist.c1e2day,
            'c1e2night': newChecklist.c1e2night,
            'c1e3day': newChecklist.c1e3day,
            'c1e3night': newChecklist.c1e3night,
            'c1e4day': newChecklist.c1e4day,
            'c1e4night': newChecklist.c1e4night,
            'c2e1day': newChecklist.c2e1day,
            'c2e1night': newChecklist.c2e1night,
            'c2e2day': newChecklist.c2e2day,
            'c2e2night': newChecklist.c2e2night,
            'inspectNameDay': newChecklist.inspectNameDay,
            // 'inspectSignDay': newChecklist.inspectSignDay,
            'inspectNameNight': newChecklist.inspectNameNight,
            // 'inspectSignNight': newChecklist.inspectSignNight,
            'watchNameDay': newChecklist.watchNameDay,
            // 'watchSignDay': newChecklist.watchSignDay,
            'watchNameNight': newChecklist.watchNameNight,
            // 'watchSignNight': newChecklist.watchSignNight,
          }));
      _items[prodIndex] = newChecklist;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteChecklist(String id) async {
    final url = Uri.parse(
        'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/checklists/$id.json?auth=$authToken');
    final existingChecklistIndex = _items.indexWhere((prod) => prod.id == id);
    var existingChecklist = _items[existingChecklistIndex];
    _items.removeAt(existingChecklistIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingChecklistIndex, existingChecklist);
      notifyListeners();
      throw HttpException('Could not delete checklist.');
    }
    existingChecklist = null;
  }
}
