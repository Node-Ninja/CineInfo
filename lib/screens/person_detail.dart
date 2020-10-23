import 'package:CineInfo/models/movie.dart';
import 'package:CineInfo/models/person.dart';
import 'package:CineInfo/screens/movie_detail.dart';
import 'package:CineInfo/services/backend_service.dart';
import 'package:flutter/material.dart';

class PersonDetail extends StatefulWidget {
  final Cast actor;

  PersonDetail({Key key, this.actor}) : super(key: key);

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  String pageTitle = 'Person Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   title: Text(pageTitle),
      //   elevation: 0.5,
      // ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Stack(
            children: [
              Hero(
                tag: '${widget.actor.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (widget.actor.profilePath != null)
                            ? NetworkImage(
                                'https://image.tmdb.org/t/p/w780${widget.actor.profilePath}')
                            : AssetImage(
                                'assets/images/blank_user.png',
                              ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Color(0xcc000000),
                          Color(0xaa000000),
                          Color(0x99000000),
                          Color(0x66000000),
                          Color(0x00000000)
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.actor.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   widget.actor.birthday ?? '',
                            //   style: TextStyle(
                            //     color: Colors.white70,
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: BackEndService().bundlePersonData(widget.actor.id),
            builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
              if (snapshot.hasData) {
                Person person = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (person.details.biography != "")
                      Container(
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Text(
                              person.details.biography,
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Movies cast in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: person.credits.cast.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<Cast_> cast = person.credits.cast;

                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              child: Container(
                                child: SizedBox(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Hero(
                                        tag: '${cast[index].id}_person',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: (cast[index].posterPath !=
                                                    null)
                                                ? NetworkImage(
                                                    'https://image.tmdb.org/t/p/w300${cast[index].posterPath}')
                                                : AssetImage(
                                                    'assets/images/poster_blank.png'),
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        cast[index].title,
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                      movieData: cast[index],
                                      heroTag: '${cast[index].id}_person',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Color(0xFFff4545),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
