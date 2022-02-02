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

  List<Checklist> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

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
      final favoriteResponse = await http.get(Uri.parse(
          'https://cefs-5580c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken'));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Checklist> loadedChecklists = [];
      extractedData.forEach((prodId, prodData) {
        loadedChecklists.add(
          Checklist(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
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
            'title': checklist.title,
            'description': checklist.description,
            'imageUrl': checklist.imageUrl,
            'price': checklist.price,
            'creatorId': userId,
          },
        ),
      );
      final newChecklist = Checklist(
          id: json.decode(response.body)['name'],
          title: checklist.title,
          description: checklist.description,
          price: checklist.price,
          imageUrl: checklist.imageUrl);
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
            'title': newChecklist.title,
            'description': newChecklist.description,
            'imageUrl': newChecklist.imageUrl,
            'price': newChecklist.price,
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
