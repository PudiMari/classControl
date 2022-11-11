
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ambient2.dart';

class Reserve2 {
  String name;
  String? notes;
  String type;
  List<Ambient2> rooms;
  String? referenceId;

  Reserve2(this.name,
      {this.notes, required this.type, this.referenceId, required this.rooms});

  factory Reserve2.fromSnapshot(DocumentSnapshot snapshot) {
    final newReserve =
        Reserve2.fromJson(snapshot.data() as Map<String, dynamic>);
    newReserve.referenceId = snapshot.reference.id;
    return newReserve;
  }

  factory Reserve2.fromJson(Map<String, dynamic> json) =>
      _reserveFromJson(json);

  Map<String, dynamic> toJson() => _reserveToJson(this);

  @override
  String toString() => 'Reserve<$name>';
}

Reserve2 _reserveFromJson(Map<String, dynamic> json) {
  return Reserve2(json['name'] as String,
      notes: json['notes'] as String?,
      type: json['type'] as String,
      rooms: _convertRooms(json['rooms'] as List<dynamic>));
}

List<Ambient2> _convertRooms(List<dynamic> map) {
  final rooms = <Ambient2>[];

  for (final room in map) {
    rooms.add(Ambient2.fromJson(room as Map<String, dynamic>));
  }
  return rooms;
}

Map<String, dynamic> _reserveToJson(Reserve2 instance) => <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'type': instance.type,
      'rooms': _roomList(instance.rooms),
    };

List<Map<String, dynamic>>? _roomList(List<Ambient2>? rooms) {
  if (rooms == null) {
    return null;
  }
  final roomMap = <Map<String, dynamic>>[];
  for (var room in rooms) {
    roomMap.add(room.toJson());
  }
  return roomMap;
}
