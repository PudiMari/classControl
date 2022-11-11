
import 'package:cloud_firestore/cloud_firestore.dart';

import 'reserve2.dart';

class ReserveServices2 {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('reservs');
  
  Stream<QuerySnapshot> getReserves() {
    return collection.snapshots();
  }

  Future<DocumentReference> addReserve(Reserve2 reserve) {
    return collection.add(reserve.toJson());
  }

  void updateReserve(Reserve2 reserve) async {
    await collection.doc(reserve.referenceId).update(reserve.toJson());
  }

  void deleteReserve(Reserve2 reserve) async {
    await collection.doc(reserve.referenceId).delete();
  }
}
