import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_check_app/models/movie.dart';

class Webservice {
  Future<List<Movie>> fetchMovies(String keyword) async {
    final url = "http://www.omdbapi.com/?s=$keyword&apikey=63fc6005";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body["Search"];
      return json.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
