import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/uitls.dart';
import 'package:news_app/widgets/tabs.dart';
import 'package:news_app/widgets/vertical_spacing.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/artical_widgets.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final Color color = Utils(context).getColor;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: color),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Text(
                'News App',
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                        color: color, fontSize: 20, letterSpacing: 0.6)),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(IconlyLight.search))
              ]),
          drawer: DrawerWidget(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    TabsWidget(
                        text: 'All news',
                        color: newsType == NewsType.topTrending
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                        function: () {
                          if (newsType == NewsType.topTrending) {
                            return;
                          }
                          setState(() {
                            newsType = NewsType.topTrending;
                          });
                        },
                        fontSize: newsType == NewsType.topTrending ? 22 : 14),
                    SizedBox(width: 25),
                    TabsWidget(
                        text: 'All news',
                        color: newsType == NewsType.topTrending
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                        function: () {
                          if (newsType == NewsType.topTrending) {
                            return;
                          }
                          setState(() {
                            newsType = NewsType.topTrending;
                          });
                        },
                        fontSize: newsType == NewsType.topTrending ? 22 : 14)
                  ],
                ),
                const VerticalSpacting(10),
                newsType == NewsType.topTrending
                    ? Container()
                    : SizedBox(
                        height: kBottomNavigationBarHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            pagiantionButtons(
                                function: () {
                                  if (currentPageIndex == 0) {
                                    return;
                                  }
                                  setState(() {
                                    currentPageIndex -= 1;
                                  });
                                },
                                text: 'prev'),
                            Flexible(
                              flex: 2,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        color: currentPageIndex == index
                                            ? Colors.blue
                                            : Theme.of(context).cardColor,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentPageIndex = index;
                                            });
                                          },
                                          child: Center(
                                              child: Text("${index + 1}")),
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                            pagiantionButtons(
                                function: () {
                                  function:
                                  () {
                                    if (currentPageIndex == 4) {
                                      return;
                                    }
                                    setState(() {
                                      currentPageIndex += 1;
                                    });
                                    print('$currentPageIndex index');
                                  };
                                },
                                text: 'next'),
                          ],
                        )),
                const VerticalSpacting(10),
                newsType == NewsType.topTrending
                    ? Container()
                    : Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                              value: sortBy,
                              items: dropDownItems,
                              onChanged: (Object? value) {},
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (ctx, index) {
                        print('Building item ${index + 1}');
                        return const ArticalWidget();
                      }),
                )
              ],
            ),
          )),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      )
    ];
    return menuItems;
  }

  Widget pagiantionButtons({required Function function, required String text}) {
    return ElevatedButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.all(6),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }
}
