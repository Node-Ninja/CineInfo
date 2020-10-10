import 'package:CineInfo/screens/about_screen.dart';
import 'package:CineInfo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Theme.of(context).primaryColor),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/logo_transparent.png'),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              leading: Icon(
                FontAwesomeIcons.search,
                color: Colors.white38,
                size: 20,
              ),
              subtitle: Text(
                'Search for movies',
                style: TextStyle(color: Colors.white24),
              ),
              title: Text(
                'Search',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
              leading: Icon(
                FontAwesomeIcons.info,
                color: Colors.grey,
                size: 20,
              ),
              subtitle: Text(
                'Information about the app',
                style: TextStyle(color: Colors.white24),
              ),
              title: Text(
                'About',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
