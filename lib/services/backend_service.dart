import 'package:CineInfo/models/movie.dart';
import 'package:CineInfo/models/person.dart' as person;
import 'package:CineInfo/models/search_result.dart';
import 'package:http/http.dart';

class BackEndService {
  //  set vars;
  static const String _apiHost = 'https://api.themoviedb.org';
  static const String _apiKey =
      String.fromEnvironment('TMDB_API_KEY', defaultValue: 'xxxx');

  /// Using the provided [type], fetch movie details.
  /// Expected types: popular, top_rated, now_showing.
  Future<SearchResult> searchMovies(String type, [String query]) async {
    Response res;
    String url;

    (query == null)
        ? url = '$_apiHost/3/movie/$type?api_key=$_apiKey'
        : url = '$_apiHost/3/search/$type?api_key=$_apiKey&query=$query';

    res = await get(url);

    if (res.statusCode == 200) {
      SearchResult results = searchResultFromJson(res.body);

      return results;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch movie details using the provided TMDB [movieId]
  Future<Details> getMovieDetails(int movieId) async {
    Response res;
    String url = '$_apiHost/3/movie/$movieId?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      Details details = detailsFromJson(res.body);

      return details;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch movie credits using the provided TMDB [movieId]
  Future<Credits> getMovieCredits(int movieId) async {
    Response res;
    String url = '$_apiHost/3/movie/$movieId/credits?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      Credits credits = creditsFromJson(res.body);

      return credits;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch movie images using the provided TMDB [movieId]
  Future<Images> getMovieImages(int movieId) async {
    Response res;
    String url = '$_apiHost/3/movie/$movieId/images?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      Images images = imagesFromJson(res.body);

      return images;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch movie videos using the provided TMDB [movieId]
  Future<Videos> getMovieVideos(int movieId) async {
    Response res;
    String url = '$_apiHost/3/movie/$movieId/videos?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      Videos videos = videosFromJson(res.body);

      return videos;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch person details using the provided TMDB [personId]
  Future<person.Details> getPersonDetails(int personId) async {
    Response res;
    String url = '$_apiHost/3/person/$personId?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      person.Details details = person.detailsFromJson(res.body);

      return details;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  /// Fetch credits (movies cast in, movies crew'd in) using the provided TMDB [personId]
  Future<person.Credits> getPersonCredits(int personId) async {
    Response res;
    String url = '$_apiHost/3/person/$personId/credits?api_key=$_apiKey';

    res = await get(url);

    if (res.statusCode == 200) {
      person.Credits credits = person.creditsFromJson(res.body);

      return credits;
    } else {
      throw <dynamic>["Something Went Wrong", res];
    }
  }

  Future<Movie> bundledMovieData(int movieId) async {
    try {
      Details details = await getMovieDetails(movieId);
      Credits credits = await getMovieCredits(movieId);
      Images images = await getMovieImages(movieId);
      Videos videos = await getMovieVideos(movieId);

      return Movie.fromJson({
        "images": images,
        "videos": videos,
        "credits": credits,
        "details": details,
        "movieId": movieId
      });
    } catch (e) {
      throw <dynamic>["Something Went Wrong", e];
    }
  }

  Future<person.Person> bundlePersonData(int personId) async {
    try {
      person.Details details = await getPersonDetails(personId);
      person.Credits credits = await getPersonCredits(personId);

      return person.Person.fromJson(
        {"details": details, "credits": credits, "personId": personId},
      );
    } catch (e) {
      throw <dynamic>["Something Went Wrong", e];
    }
  }
}
