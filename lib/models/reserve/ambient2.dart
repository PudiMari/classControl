import 'package:cloud_firestore/cloud_firestore.dart';

class Ambient2 {
  final String room;
  final DateTime date;
  bool? done;

  Ambient2(this.room, {required this.date, this.done});

  factory Ambient2.fromJson(Map<String, dynamic> map) => _roomFromJson(map);

  Map<String, dynamic> toJson() => _roomToJson(this);

  @override
  String toString() => 'Room<$room>';
}

Ambient2 _roomFromJson(Map<String, dynamic> map) {
  return Ambient2(
    map['room'] as String,
    date: (map['date'] as Timestamp).toDate(),
    done: map['done'] as bool,
  );
}

Map<String, dynamic> _roomToJson(Ambient2 instance) => <String, dynamic>{
      'room': instance.room,
      'date': instance.date,
      'done': instance.done,
    };
