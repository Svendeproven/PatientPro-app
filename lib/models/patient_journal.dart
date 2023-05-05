/// PatientJournal model
class PatientJournal {
  int id;
  String description;
  DateTime createdAt;

  /// Constructor for creating a new patient journal
  PatientJournal({
    required this.id,
    required this.description,
    required this.createdAt,
  });

  /// Converts a json object to a PatientJournal object
  factory PatientJournal.fromJson(Map<String, dynamic> json) => PatientJournal(
        id: json["id"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  /// Converts a PatientJournal object to a json object
  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
      };
}
