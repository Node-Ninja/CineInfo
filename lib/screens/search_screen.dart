import 'package:CineInfo/models/search_result.dart';
import 'package:CineInfo/screens/movie_detail.dart';
import 'package:CineInfo/services/backend_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //  create form
  final _formKey = GlobalKey<FormState>();
  String searchQuery = '';
  bool searching = false;
  List<Result> results = [];

  void searchMovies() async {
    setState(() {
      searching = true;
    });
    BackEndService().searchMovies('movie', searchQuery).then((response) {
      setState(() {
        results = response.results;
        setState(() {
          searching = false;
        });
      });
    }, onError: (error) {
      print(error);
      setState(() {
        searching = false;
      });
    });
  }

  Widget searchedMovies() {
    if (searching) {
      return Stack(
        children: [
          LinearProgressIndicator(backgroundColor: Color(0xFFff4545)),
        ],
      );
    } else {
      return ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(30)),
        child: (results.length == 0)
            ? Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/nothing.png',
                  ),
                  width: 200,
                  height: 200,
                ),
              )
            : ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                movieData: results[index],
                                heroTag: '${results[index].id}_search',
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0.5,
                          color: Theme.of(context).primaryColor,
                          child: ListTile(
                            leading: (results[index].posterPath == null)
                                ? Hero(
                                    tag: '${results[index].id}_search',
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/poster_blank.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Hero(
                                    tag: '${results[index].id}_search',
                                    child: Image(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w300${results[index].posterPath}'),
                                    ),
                                  ),
                            title: Text(
                              results[index].title,
                              style: TextStyle(color: Colors.white30),
                            ),
                            subtitle: Text(
                              (results[index].releaseDate != null)
                                  ? results[index]
                                      .releaseDate
                                      .toString()
                                      .substring(0, 10)
                                  : 'Not Available',
                              style: TextStyle(color: Colors.white38),
                            ),
                            trailing: Icon(
                              FontAwesome.chevron_right,
                              color: Colors.white38,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text('Search'),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).accentColor,
                ),
                child: searchedMovies(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: TextFormField(
                        autofocus: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something to search';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Search movies',
                            hintStyle: TextStyle(color: Colors.white38)),
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            searchMovies();
                          });
                        },
                      ),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(FontAwesomeIcons.search,
                  //       color: Colors.white38, size: 20),
                  //   onPressed: () {
                  //     if (_formKey.currentState.validate()) {
                  //       searchMovies();
                  //     } else {
                  //       print('invalid');
                  //     }
                  //   },
                  // )
                ],
              ),
            )
          ],
        ));
  }
}
