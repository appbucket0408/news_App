class NewsModel {
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

  NewsModel(
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
      this.readingTimeText});

  factory NewsModel.fromJson(dynamic json) {
    return NewsModel(
        authorName: json['author'] ?? "",
        sourceName: json['source']['name'] ?? "",
        newsId: json['source']['id'] ?? "",
        content: json['content'] ?? "",
        description: json['description'] ?? "",
        publishedAt: json['publishedAt'],
        url: json['url'] ?? "",
        title: json['title'] ?? "",
        urlToImage: json['urlToImage'] ??  "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1",
        dateToShow: "dateToShow",
        readingTimeText: "readingTimeText");
  }
  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
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
