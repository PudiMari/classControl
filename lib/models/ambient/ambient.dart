import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ambient extends ChangeNotifier {
  String? id;
  String? room;
  String? status;

  Ambient({this.id, this.room, this.status}) {
    id = id ?? '';
    room = room ?? '';
    status = status ?? '';
  }

  factory Ambient.fromJson(Map<String, dynamic> map) => _areaFromJson(map);

  factory Ambient.fromSnapshot(DocumentSnapshot snapshot) {
    final area = Ambient.fromJson(snapshot.data() as Map<String, dynamic>);
    area.id = snapshot.reference.id;
    return area;
  }
  //método construtor para salvar os dados do documento firebase
  Ambient.fromDocument(DocumentSnapshot document) {
    id = document.id;
    room = document['area'] as String;
    //vem do firebase uma lista dinâmica que será convertida em string localmente
    status = document['status'] as String;
  }

  Ambient clone() {
    return Ambient(
      id: id,
      room: room,
      status: status,
    );
  }

  Map<String, dynamic> toJson() => _areaToJson(this);

  @override
  String toString() => 'Area<$room>';
}

Ambient _areaFromJson(Map<String, dynamic> map) {
  return Ambient(
    id: map['id'] as String,
    room: map['area'] as String,
    status: map['status'] as String,
  );
}

Map<String, dynamic> _areaToJson(Ambient ambient) => <String, dynamic>{
      'area': ambient.room,
      'status': ambient.status,
    };
