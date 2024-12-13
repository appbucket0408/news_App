import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../consts/api_consts.dart';
import '../models/bookmark_model.dart';
import '../models/news_model.dart';
import '../services/news_api.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookMarksModel> bookmarkList = [];
  List<BookMarksModel> get getbookmarkList {
    return bookmarkList;
  }

  Future<List<BookMarksModel>> fetchBookMarks() async {
    bookmarkList = await NewsApiServices.getBookmarks() ?? [];
    notifyListeners();
    return bookmarkList;
  }

  Future<void> addToBookmark({required NewsModel newsmodel}) async {
    try {
      var uri = Uri.https(BASEURL_Firebase, "bookmarks.json");

      var response =
          await http.post(uri, body: json.encode(newsmodel.toJson()));
            notifyListeners();
      print(response.statusCode);
      
      log(response.body);
      // Map data = jsonDecode(response.body);
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> deleteBookmark({required String key}) async {
    try {
      var uri =
          Uri.https(BASEURL_Firebase, "bookmarks/$key.json");

      var response = await http.delete(
        uri,
      );
        notifyListeners();
      print('in delete api ${response.statusCode}');
      log(response.body);
      // Map data = jsonDecode(response.body);
    } catch (e) {
      throw '$e';
    }
  }
}
