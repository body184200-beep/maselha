import '../../models/word_model.dart';
import 'animals_words.dart';
import 'jobs_words.dart';
import 'movies_words.dart';
import 'series_words.dart';
import 'sports_words.dart';
import 'things_words.dart';

/// All bundled words. Add a new category file and list it here.
const List<WordModel> allLocalWords = [
  ...animalsWords,
  ...jobsWords,
  ...moviesWords,
  ...seriesWords,
  ...sportsWords,
  ...thingsWords,
];