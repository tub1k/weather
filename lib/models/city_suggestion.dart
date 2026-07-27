class CitySuggestion {
  final String displayName; 
  final String query;  

  CitySuggestion({required this.displayName, required this.query});

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      displayName: "${json['name']}, ${json['country']}",
      query: json['url'], 
    );
  }
}