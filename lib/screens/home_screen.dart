import 'package:CineInfo/screens/search_screen.dart';
import 'package:CineInfo/widgets/common/category.dart';
import 'package:CineInfo/widgets/common/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('CineInfo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            iconSize: 20,
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          )
        ],
        elevation: 0.0,
      ),
      drawer: AppDrawer(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Popular movies',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Category(
            category: 'popular',
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'In Theatres',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Category(
            category: 'now_playing',
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Top Rated Movies',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Category(
            category: 'top_rated',
          ),
        ],
      ),
    );
  }
}
