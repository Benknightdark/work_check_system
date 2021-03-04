import 'package:flutter/cupertino.dart';
import 'package:work_check_app/services/api/webservice.dart';

import 'movie_view_model.dart';

class MovieListViewModel extends ChangeNotifier {
  List<MovieViewModel> movies = List<MovieViewModel>();

  Future<void> fetchMovies(String keyword) async {
    final results = await Webservice().fetchMovies(keyword);
    this.movies = results.map((item) => MovieViewModel(movie: item)).toList();
    print(this.movies);
    notifyListeners();
  }
}
