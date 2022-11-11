// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Book {
  String? id;
  String ambientId;
  DateTime bookingDay;
  String unitId;
  String userId;
  Book(
      {required this.ambientId,
      required this.bookingDay,
      required this.unitId,
      required this.userId}) {
    debugPrint("Id da ambiente ${ambientId.toString()}");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ambientId': ambientId,
      'bookingDay': bookingDay, //as Timestamp).toDate(),
      'unitId': unitId,
      'userId': userId,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      ambientId: map['ambientId'] as String,
      bookingDay: (map['bookingDay'] as Timestamp).toDate(),
      unitId: map['unitId'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, ambientId: $ambientId, bookingDay: $bookingDay, unitId: $unitId,userId: $userId)';
  }
}
