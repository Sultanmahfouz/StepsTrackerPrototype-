class Competitor {
  final String name;
  final String score;

  Competitor({this.name, this.score});


  factory Competitor.fromMap(Map data) {
    data = data ?? {};
    return Competitor(
      name: data['name'] ?? '',
      score: data['score'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'score': this.score,
    };
  }
  
}
