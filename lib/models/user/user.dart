import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocal {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  bool admin = false;
  //métodos construtores
  UserLocal({this.id, this.name, this.email, this.password});

  UserLocal.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name') as String;
    email = doc.get('email') as String;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
