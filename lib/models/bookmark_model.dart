import 'package:flutter/widgets.dart';
import 'package:reading_time/reading_time.dart';

import '../services/global_methods.dart';

class BookMarksModel with ChangeNotifier {
  String? bookmarkKey;
  String? newsId;
  String? sourceName;
  String? authorName;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? dateToShow;
  String? content;
  String? readingTimeText;

  BookMarksModel(
      {this.sourceName,
      this.authorName,
      this.content,
      this.description,
      this.newsId,
      this.publishedAt,
      this.title,
      this.url,
      this.urlToImage,
      this.dateToShow,
      this.readingTimeText,
      this.bookmarkKey});

  factory BookMarksModel.fromJson(
      {required dynamic json, required bookmarkKey}) {
    String title = json['title'] ?? "No title";
    String content = json['content'] ?? "";
    String description = json['description'] ?? "";
    String dateToShow = "";
    if (json["publishedAt"] != null) {
      dateToShow = GlobalMethods.formattedDateText(json['publishedAt']);
    }

    return BookMarksModel(
        bookmarkKey: bookmarkKey,
        authorName: json['author'] ?? "Unknown Author",
        sourceName: json['source']?['name'] ?? "Unknown Source",
        newsId: json['source']?['id'] ?? "Unknown ID",
        content: content,
        description: description,
        publishedAt: json['publishedAt'],
        url: json['url'] ?? "",
        title: title,
        urlToImage: json['urlToImage'] ??
            "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1",
        dateToShow: dateToShow,
        readingTimeText: readingTime(title + description + content).msg);
  }
  // static List<BookMarksModel> bookMarksSnapshot(
  //     {required dynamic json, required List allKeys}) {
  //   return allKeys.map((key) {
      
  //     return BookMarksModel.fromJson(json: json[allKeys], bookmarkKey: key);
  //   }).toList();
  // }
  static List<BookMarksModel> bookMarksSnapshot({
  required dynamic json,
  required List allKeys,
}) {
  return allKeys
      .map((key) {
        // Ensure each entry is not null
        if (json[key] == null) {
          print("Skipping null entry for key: $key");
          return null;
        }
        // Safely create a BookMarksModel
        return BookMarksModel.fromJson(json: json[key], bookmarkKey: key);
      })
      .where((bookmark) => bookmark != null) // Filter out nulls
      .toList()
      .cast<BookMarksModel>(); // Ensure correct type
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["NewsId"] = newsId;
    data["authorName"] = authorName;
    data["sourceName"] = sourceName;
    data["content"] = content;
    data["description"] = description;
    data["publishedAt"] = publishedAt;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["dateToShow"] = dateToShow;
    data["readingTimeText"] = readingTimeText;
    return data;
  }
}
