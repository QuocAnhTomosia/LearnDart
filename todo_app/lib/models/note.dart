class Note {
  final int? id;
  final String title;
  final String details;
  final String start;
  final String end;

  Note(
      {this.id,
      required this.title,
      required this.details,
      required this.start,
      required this.end});

  factory Note.fromMap(Map<String, dynamic> json) => Note(
      id: json["id"],
      title: json["title"],
      details: json["details"],
      start: json['start'],
      end: json["end"]);
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      "details": details,
      "start": start,
      "end":end
    };
  }
}
