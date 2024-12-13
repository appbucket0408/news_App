import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter_course/models/bookmark_model.dart';
import 'package:news_app_flutter_course/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../providers/bookmark_provider.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/loading_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
      ),
      body: FutureBuilder<List<BookMarksModel>>(
        future: Provider.of<BookmarksProvider>(context, listen: false)
            .fetchBookMarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
              child: LoadingWidget(newsType: NewsType.allNews),
            );
          } else if (snapshot.hasError) {
            return EmptyNewsWidget(
                text: "an error occured ${snapshot.error}",
                imagePath: 'assets/images/no_news.png');
          } else if (snapshot.data == null) {
            return Expanded(
              child: EmptyNewsWidget(
                  text: "No news Found ${snapshot.error}",
                  imagePath: 'assets/images/no_news.png'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const ArticlesWidget(isBookmark: true));
              });
        },
      ),
    );
  }
}
