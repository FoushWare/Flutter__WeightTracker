import 'package:firebase_database/firebase_database.dart';

class WeightEntry {
  String key;
  DateTime dateTime;
  double weight;
  String note;

  WeightEntry(this.dateTime, this.weight, this.note);

  /// To push an object into database we can just call push and set methods on reference object.
  /// mainReference.push().set(...);
  /// However the set method doesn’t accept just an object
  WeightEntry.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
        new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        weight = snapshot.value["weight"].toDouble(),
        note = snapshot.value["note"];

  toJson() {
    return {
      "weight": weight,
      "date": dateTime.millisecondsSinceEpoch,
      "note": note
    };
  }
}
