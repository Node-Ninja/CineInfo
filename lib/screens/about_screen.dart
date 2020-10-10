import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreen createState() => _AboutScreen();
}

class _AboutScreen extends State<AboutScreen> {
  final List<String> tabs = ['Information', 'Developer', 'Third Party'];
  String appName = '';
  String appVersion = '';
  String appBuild = '';
  String package = '';

  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        appVersion = packageInfo.version;
        appBuild = packageInfo.buildNumber;
        package = packageInfo.packageName;
      });
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('About'),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // color: Theme.of(context).accentColor,
              border: Border(top: BorderSide(color: Colors.black12)),
            ),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/logo_transparent.png'),
                        width: 100,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Name : $appName',
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      ),
                      Text(
                        'Version : $appVersion+$appBuild',
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      ),
                      Text(
                        'Package : $package',
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'CineInfo',
                      style: TextStyle(
                          color: Colors.white24,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Expanded(
                        child: ListView(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              enabled: false,
                              title: Text(
                                'Website',
                                style: TextStyle(color: Colors.white38),
                              ),
                              leading: Icon(
                                FontAwesomeIcons.globe,
                                color: Colors.white38,
                              ),
                              trailing: Text(
                                'www.cineinfo.co.za',
                                style: TextStyle(color: Colors.white38),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              enabled: false,
                              title: Text(
                                'Email',
                                style: TextStyle(color: Colors.white38),
                              ),
                              leading: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.white38,
                              ),
                              trailing: Text(
                                'info@cineinfo.co.za',
                                style: TextStyle(color: Colors.white38),
                              ),
                            ),
                            // ListTile(
                            //   contentPadding: EdgeInsets.zero,
                            //   dense: true,
                            //   enabled: false,
                            //   title: Text(
                            //     'LinkedIn',
                            //     style: TextStyle(color: Colors.white38),
                            //   ),
                            //   leading: Icon(
                            //     FontAwesomeIcons.linkedinIn,
                            //     color: Colors.white38,
                            //   ),
                            //   trailing: Text(
                            //     'Donald Sepeng',
                            //     style: TextStyle(color: Colors.white38),
                            //   ),
                            // ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              enabled: false,
                              title: Text(
                                'Github',
                                style: TextStyle(color: Colors.white38),
                              ),
                              leading: Icon(
                                FontAwesomeIcons.github,
                                color: Colors.white38,
                              ),
                              trailing: Text(
                                'Node-Ninja',
                                style: TextStyle(color: Colors.white38),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              enabled: false,
                              title: Text(
                                'TMDB',
                                style: TextStyle(color: Colors.white38),
                              ),
                              leading: Image(
                                image: AssetImage('assets/images/tmdb.png'),
                                width: 30,
                              ),
                              trailing: Text(
                                'The Movie Database',
                                style: TextStyle(color: Colors.white38),
                              ),
                            ),
                            // ListTile(
                            //   contentPadding: EdgeInsets.zero,
                            //   dense: true,
                            //   enabled: false,
                            //   title: Text(
                            //     'OMDB',
                            //     style: TextStyle(color: Colors.white38),
                            //   ),
                            //   leading: Image(
                            //     image: NetworkImage(
                            //         'https://upload.wikimedia.org/wikipedia/commons/a/a9/Omdb-logo.png'),
                            //     width: 30,
                            //   ),
                            //   trailing: Text(
                            //     'Open Movie Database',
                            //     style: TextStyle(color: Colors.white38),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Made with \u2764️ and flutter',
                  style: TextStyle(color: Colors.white38),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
