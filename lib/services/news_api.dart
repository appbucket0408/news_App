import 'dart:convert';
import 'dart:developer';

import '../consts/api_consts.dart';
import '../consts/http_exceptions.dart';
import '../models/bookmark_model.dart';
import '../models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiServices {
  Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=c026b13d7a074574bff2095bd35407e4');
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "bbc.co.uk,techcrunch.com,engadet.com",
        "page": page.toString(),
        "sortBy": sortBy
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

  Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        'country': 'us'
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

  Future<List<NewsModel>> searchNews({required String query}) async {
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

  // static Future<List<BookMarksModel>?> getBookmarks() async {
  //   try {
  //     var uri = Uri.https(BASEURL_Firebase, "bookmarks.json");

  //     var response = await http.get(
  //       uri,
  //     );
  //     // print(response.statusCode);
  //     // log(response.body);
  //     Map data = jsonDecode(response.body);
  //     List allKeys = [];
  //     if (data['code'] == null) {
  //       throw HttpException(data['code']);
  //     }
  //     for (String key in data.keys) {
  //       allKeys.add(key);
  //     }
  //     return BookMarksModel.bookMarksSnapshot(json: data, allKeys: allKeys);

  //   } catch (e, stackTrace) {
  //   print("Error in getBookmarks: $e");
  //   print("Stack trace: $stackTrace");
  //   return null;
  // }
  // }


   static Future<List<BookMarksModel>?> getBookmarks() async {
  var uri = Uri.https(BASEURL_Firebase, "bookmarks.json");

  try {
    // Perform the HTTP GET request
    var response = await http.get(uri);

    // Check HTTP response status code
    if (response.statusCode != 200) {
      print("HTTP request failed with status code ${response.statusCode}");
      return null; // Return null if the request fails
    }

    // Log the response body
    log(response.body);

    // Check if the response body is empty
    if (response.body.isEmpty) {
      print("Empty response body received from the API");
      return null; // Return null if the body is empty
    }

    // Parse the JSON response
    Map<String, dynamic>? data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      print("Failed to parse JSON: $e");
      return null; // Return null if parsing fails
    }

    // Validate the parsed data
    if (data == null || data.isEmpty) {
      print("Parsed data is null or empty");
      return null; // Return null if the data is invalid
    }

    // Extract keys and generate bookmark models
    List<String> allKeys = data.keys.toList();
    return BookMarksModel.bookMarksSnapshot(json: data, allKeys: allKeys);
  } catch (e, stackTrace) {
    print("Error in getBookmarks: $e");
    print("Stack trace: $stackTrace");
    return null;
  }
}

}
