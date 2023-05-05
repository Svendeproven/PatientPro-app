/// Medicine model
class Medicine {
  int id;
  String title;
  String description;
  double pricePrMg;
  String activeSubstance;

  /// Constructor for creating a new medicine
  Medicine({
    required this.id,
    required this.title,
    required this.description,
    required this.pricePrMg,
    required this.activeSubstance,
  });

  /// Converts a json object to a Medicine object
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      pricePrMg: double.parse(json['pricePrMg'].toString()),
      activeSubstance: json['activeSubstance'],
    );
  }

  /// Converts a Medicine object to a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pricePrMg': pricePrMg,
      'activeSubstance': activeSubstance,
    };
  }
}
