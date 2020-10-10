import 'package:CineInfo/models/search_result.dart';
import 'package:CineInfo/screens/movie_detail.dart';
import 'package:CineInfo/services/backend_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Category extends StatefulWidget {
  final String category;

  Category({Key key, this.category}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: FutureBuilder(
          future: BackEndService().searchMovies(widget.category),
          builder:
              (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
            if (snapshot.hasData) {
              SearchResult results = snapshot.data;
              List<Result> movies = results.results;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                movieData: movies[index],
                                heroTag:
                                    '${movies[index].id}_${widget.category}',
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: '${movies[index].id}_${widget.category}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w300${movies[index].posterPath}'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                movies[index].title,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.star,
                                    color: Colors.yellow,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    movies[index].voteAverage.toString(),
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Stack(children: <Widget>[
                LinearProgressIndicator(
                  backgroundColor: Color(0xFFff4545),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                )
              ]);
            }
          },
        ));
  }
}
