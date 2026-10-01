/// Every URL the app talks to, in one place.
class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = 'https://maselha.pythonanywhere.com/api';

  static const categories = '/categories/';
  static const difficultyLevels = '/difficulty-levels/';
  static const randomWord = '/random-word/';
  static const addSuggestedWord = '/add-suggested-word/';

// Admin only (needs authentication), so the app does not call it:
// static String approveSuggestedWord(int id) =>
//     '/suggested-words/$id/approve/';
}