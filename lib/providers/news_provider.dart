import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/news_api.dart';

class NewsProvider with ChangeNotifier {
  NewsApiServices getnews = NewsApiServices();
  List<NewsModel> newList = [];
  List<NewsModel> get getNewsList {
    return newList;
  }

  Future<List<NewsModel>> fetchAllNews() async {
    newList = await getnews.getAllNews();
    return newList;
  }
}
