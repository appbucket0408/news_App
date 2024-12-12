import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/news_api.dart';

class NewsProvider with ChangeNotifier {
  NewsApiServices getnews = NewsApiServices();
  List<NewsModel> newsList = [];
  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews(
      {required int pageIndex, required String sortBy}) async {
    newsList = await getnews.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
  }

    Future<List<NewsModel>> fetchTopHeadLines(
     ) async {
    newsList = await getnews.getTopHeadlines();
    return newsList;
  }

  NewsModel findByDate({required String publishedAt}) {
    return newsList
        .firstWhere((newsModel) => newsModel.publishedAt == publishedAt);
  }
}
