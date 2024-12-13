import 'dart:convert';

import '../consts/api_consts.dart';
import '../consts/http_exceptions.dart';
import '../models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiServices {
  Future<List<NewsModel>> getAllNews({required int page, required String sortBy}) async {
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=c026b13d7a074574bff2095bd35407e4');
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "bbc.co.uk,techcrunch.com,engadet.com",
        "page": page.toString(),
        "sortBy":sortBy
        // "apiKey": API_KEY
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});

      Map data = jsonDecode(response.body);
      List newsTempList = data["articles"];
      if (data['code'] != null) {
        // throw "An error occured you do'nt have a key";
        throw HttpException(data['code']);
      }
      return newsTempList
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<NewsModel>>getTopHeadlines()async{
       try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
       'country':'us'
        // "apiKey": API_KEY
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});

      Map data = jsonDecode(response.body);
      List newsTempList = data["articles"];
      if (data['code'] != null) {
        // throw "An error occured you do'nt have a key";
        throw HttpException(data['code']);
      }
      return newsTempList
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

    Future<List<NewsModel>> searchNews({ required String query}) async {
   
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "bbc.co.uk,techcrunch.com,engadet.com",
      
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});

      Map data = jsonDecode(response.body);
      List newsTempList = data["articles"];
      if (data['code'] != null) {
        // throw "An error occured you do'nt have a key";
        throw HttpException(data['code']);
      }
      return newsTempList
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
