
import 'package:cloud_firestore/cloud_firestore.dart';

import '../resident/employer.dart';

class Unit {
  String? id;
  String? description;
  List<Employer>? employers;

  Unit(this.description, this.employers);

  //método construtor para salvar os dados do documento no Firebase
  Unit.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    description = doc.get('name') as String;
    employers = (doc.get('employers') as List<dynamic>)
        .map((s) => Employer.fromMap(s as Map<String, dynamic>))
        .toList();
  }
  //método para converter formato json em objetos
  Unit.fromMap(Map<String, dynamic> map)
      : description = map['description'],
        employers = map['employers'];

  //permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'employers': employers,
    };
  }

  List<Map<String, dynamic>>? exportREsidentList() {
    return employers?.map((resident) => resident.toMap()).toList();
  }
}
