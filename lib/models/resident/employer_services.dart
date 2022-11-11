
import 'package:cloud_firestore/cloud_firestore.dart';

import 'employer.dart';

class ResidentServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //método é utilizado para gravar dados no Firebase
  addResident(Employer resident) {
    _firestore.collection('residents').add(resident.toMap());
  }
}
