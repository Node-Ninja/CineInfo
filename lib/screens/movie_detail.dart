import 'package:CineInfo/services/backend_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:CineInfo/models/languages.dart';
import 'package:CineInfo/util/genres.dart';
import 'package:CineInfo/screens/person_detail.dart';
import 'package:CineInfo/util/languages.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:CineInfo/models/movie.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  final dynamic movieData;
  final String heroTag;

  MovieDetail({Key key, this.movieData, this.heroTag}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  //  set vars;
  final currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\$");
  final dateFormat = DateFormat('MMMM dd, yyyy');
  final yearFormat = DateFormat('yyyy');

  final Color headingColor = Colors.white;
  final Color textColor = Colors.white60;

  //  this is a map of ISO-639-1 language codes and names;
  final Map<String, Languages> languages = new LanguageCodes().getLanguages();

  final Map<String, dynamic> genres = new Genres().getGenres();

  //  this method is used to launch a browser/youtube to view trailer;
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //  TODO: Handle this better in future;
      throw 'Could not launch $url';
    }
  }

  //  convert minutes to h:m
  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0]}h ${parts[1].padLeft(2, '0')}m';
  }

  @override
  Widget build(BuildContext context) {
    //  set variables;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (widget.movieData.backdropPath != null)
                    ? CachedNetworkImageProvider(
                        'https://image.tmdb.org/t/p/w780${widget.movieData.backdropPath}',
                      )
                    : AssetImage(
                        'assets/images/poster_blank.png',
                      ),
                fit: BoxFit.cover,
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
                Container(
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Hero(
                          tag: '${widget.heroTag}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: (widget.movieData.posterPath != null)
                                  ? NetworkImage(
                                      'https://image.tmdb.org/t/p/w300${widget.movieData.posterPath}',
                                    )
                                  : AssetImage(
                                      'assets/images/poster_blank.png',
                                    ),
                              width: 70,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.movieData.title,
                                style: TextStyle(
                                  color: headingColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                (widget.movieData.releaseDate != null)
                                    ? yearFormat
                                        .format(widget.movieData.releaseDate)
                                    : 'Not Available',
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.movieData.genreIds.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                        right: 10,
                                        bottom: 20),
                                    child: FlatButton(
                                      child: Text(
                                        genres[widget.movieData.genreIds[index]
                                            .toString()],
                                        style: TextStyle(color: Colors.white60),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          side: BorderSide(
                                              color: Colors.white60)),
                                      onPressed: () {},
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    for (var i = 0;
                        i < widget.movieData.voteAverage.floor();
                        i++)
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.movieData.voteAverage}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.movieData.overview,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Color(0xFFAEBBC1), height: 1.7),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: BackEndService().bundledMovieData(
              widget.movieData.id,
            ),
            builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
              if (snapshot.hasData) {
                Details movieDetails = snapshot.data.details;
                Credits movieCredits = snapshot.data.credits;
                Videos movieVideos = snapshot.data.videos;
                Images movieImages = snapshot.data.images;

                return Column(
                  children: [
                    if (movieVideos.results.length != 0 &&
                        (movieVideos.results[0].type.toLowerCase() ==
                                'trailer' ||
                            movieVideos.results[0].type.toLowerCase() ==
                                'teaser'))
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlatButton(
                              color: Theme.of(context).accentColor,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color: textColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'View Trailer',
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                _launchURL(
                                    'https://www.youtube.com/watch?v=${movieVideos.results[0].key}');
                              },
                            ),
                          ],
                        ),
                      ),
                    if (movieCredits.cast.length != 0)
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.yellowAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: 260,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Cast',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieCredits.cast.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool last =
                                        movieCredits.cast.length == (index + 1);
                                    EdgeInsets margin;

                                    (last)
                                        ? margin =
                                            EdgeInsets.symmetric(horizontal: 10)
                                        : margin = EdgeInsets.only(left: 10);

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PersonDetail(
                                              actor: movieCredits.cast[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(left: 10),
                                        margin: margin,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        width: 120,
                                        child: Column(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              child: Hero(
                                                tag:
                                                    '${movieCredits.cast[index].id}',
                                                child: Container(
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: (movieCredits
                                                                  .cast[index]
                                                                  .profilePath !=
                                                              null)
                                                          ? NetworkImage(
                                                              'https://image.tmdb.org/t/p/w300${movieCredits.cast[index].profilePath}')
                                                          : AssetImage(
                                                              'assets/images/blank_user.png',
                                                            ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                movieCredits.cast[index].name,
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                movieCredits
                                                    .cast[index].character,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (movieCredits.crew.length != 0)
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.yellowAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: 260,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Crew',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieCredits.crew.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      width: 120,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: (movieCredits
                                                              .crew[index]
                                                              .profilePath !=
                                                          null)
                                                      ? NetworkImage(
                                                          'https://image.tmdb.org/t/p/w300${movieCredits.crew[index].profilePath}')
                                                      : AssetImage(
                                                          'assets/images/blank_user.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movieCredits.crew[index].name,
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movieCredits.crew[index].job,
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                'More Information',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.dollar,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Budget',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (movieDetails.budget == 0)
                                          ? 'Not Available'
                                          : currencyFormat
                                              .format(movieDetails.budget),
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.dollar,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Revenue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (movieDetails.revenue == 0)
                                          ? 'Not Available'
                                          : currencyFormat
                                              .format(movieDetails.revenue),
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.question,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      movieDetails.status,
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.calendar,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Release',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (movieDetails.releaseDate != null)
                                          ? dateFormat
                                              .format(movieDetails.releaseDate)
                                          : 'Not Available',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.language,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Language',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${languages[movieDetails.originalLanguage.toLowerCase()].name}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.clock_o,
                                      color: Colors.yellowAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Runtime',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (movieDetails.runtime == 0 ||
                                              movieDetails.runtime == null)
                                          ? 'Not Available'
                                          : '${durationToString(movieDetails.runtime)}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    if (movieImages.backdrops.length != 0)
                      Container(
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Photo Gallery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieImages.backdrops.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Image(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w300${movieImages.backdrops[index].filePath}'),
                                        height: 80,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
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
          ),
        ],
      ),
    );
  }
}
