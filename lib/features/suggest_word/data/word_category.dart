class WordCategory {
  final int id;
  final String name;

  const WordCategory({required this.id, required this.name});

  factory WordCategory.fromJson(Map<String, dynamic> json) =>
      WordCategory(id: json['id'] as int, name: json['name'] as String);
}