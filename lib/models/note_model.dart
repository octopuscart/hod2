// ignore_for_file: unnecessary_null_comparison

class Note {
  int id = 0;
  String title = "";
  String description = "";
  String date = "";

  Note(String s,
      {required this.title,
      required this.date,
      this.id = 0,
      required this.description});

  Note.withId(
      {required this.title,
      required this.date,
      this.id = 0,
      required this.description});

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];

    title = map['title'];
    description = map['description'];
    date = map['date'];
  }
}
