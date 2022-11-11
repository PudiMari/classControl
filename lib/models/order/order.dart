import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String? orderId;
  String employerId;
  String description;
  String type;
  DateTime receipt;
  DateTime withdrawal;
  String comments;
  Order({
    required this.employerId,
    required this.description,
    required this.type,
    required this.receipt,
    required this.withdrawal,
    required this.comments,
  });

  Map<String, dynamic> toMap(Order order) {
    return <String, dynamic>{
      'employerId': order.employerId,
      'description': order.description,
      'type': order.type,
      'receipt': order.receipt,
      'withdrawal': order.withdrawal,
      'comments': order.comments,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      employerId: map['employerId'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      receipt: (map['receipt'] as Timestamp).toDate(),
      withdrawal: (map['withdrawal'] as Timestamp).toDate(),
      comments: map['comments'] as String,
    );
  }

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderId: $orderId, employerId: $employerId, description: $description, type: $type, receipt: $receipt, withdrawal: $withdrawal, comments: $comments)';
  }
}
