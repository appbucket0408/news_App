import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/uitls.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => drawerWidgetState();
}

class drawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color color = Utils(context).getColor;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset('assets/images/newspaper.png',
                    height: 60, width: 60),
              ),
              const VerticalSpacting(
                20,
              ),
              Flexible(
                child: Text('News App',
                    style: GoogleFonts.lobster(
                        textStyle: TextStyle(
                            color: color, fontSize: 20, letterSpacing: 0.6))),
              )
            ],
          ),
        ),
        const VerticalSpacting(
          20,
        ),
        CustomListTile(
          label: 'Home',
          fct: () {},
          icon: IconlyBold.home,
        ),
        CustomListTile(
          label: 'Bookmark',
          fct: () {},
          icon: IconlyBold.bookmark,
        ),
        const Divider(
          thickness: 5,
        ),
        SwitchListTile(
            title: Text(themeProvider.getDarkTheme ? 'Dark' : 'Light',
                style: TextStyle(
                  color: color,
                  fontSize: 20)),
            secondary: Icon(
              themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: 
             Theme.of(context).colorScheme.secondary,
            ),
            value: themeProvider.getDarkTheme,
            onChanged: (bool value) {
              setState(() {
                themeProvider.setDarkTheme = value;
              });
            }),
      ]),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key, required this.label, required this.fct, required this.icon,})
      : super(key: key);
  final String label;
  final Function fct;
  final IconData icon;
  
  @override
  Widget build(BuildContext context) {
        final Color color = Utils(context).getColor;

    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(label, style: TextStyle(color: color, fontSize: 20)),
      onTap: () {
        fct();
      },
    );
  }
}
