import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ambient.dart';

class AmbientServices extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('ambient');

  String? room;
  List<Ambient> allAmbient = [];

  AmbientServices();

// StreamSubscription _subscription;
  //Observar que esta variável não pode ser nula, por isto está inicializada
  //com '' (vazio)
  String _search = '';
  //utilizado pela pesquisa da listagem de produtos
  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<DocumentReference> addAmbient(Ambient ambient) {
    return collectionRef.add(ambient.toJson());
  }

  void updateAmbient(Ambient ambient) async {
    await collectionRef.doc(ambient.id).update(ambient.toJson());
  } 


  void deleteAmbient(String id) async {
    await collectionRef.doc(id).delete();
  }

  Stream<QuerySnapshot> getAmbients() {
    return collectionRef.snapshots();
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("ambient").get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (!allAmbient
          .contains(Ambient.fromDocument(querySnapshot.docs[i]))) {
        allAmbient.add(Ambient.fromDocument(querySnapshot.docs[i]));
      }
    }
  }

  //busca todas as áreas
  Future<void> _loadAllAmbients() async {
    // debugPrint('Dentro do loadAllAmbients');
    firestore
        .collection('ambient')
        .where('status', isEqualTo: "disponível")
        .snapshots()
        .listen(
      (snapshot) {
        allAmbient =
            snapshot.docs.map((c) => Ambient.fromDocument(c)).toList();
        notifyListeners();
      },
    );
  }

  Future<void> loadAmbient(String id, {Function? getData}) async {
    var collection = firestore.collection('ambient');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      getData!(data?['room']);
    }
  }

  Future<String> loadAmbient2(String id) async {
    var collection = firestore.collection('ambient');
    var docSnapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    return Future.value(data!['room']);
  }

  //utilizado para detectar se está havendo uma consulta
  List<Ambient> get filteredAmbients {
    final List<Ambient> filteredAmbients = [];
    if (search.isEmpty) {
      filteredAmbients.addAll(allAmbient);
    } else {
      filteredAmbients.addAll(
        allAmbient.where(
          (p) => p.room!.toLowerCase().contains(
                search.toLowerCase(),
              ),
        ),
      );
    }
    for (int i = 0; i < filteredAmbients.length; i++) {
      final f = filteredAmbients[i];
      debugPrint("${f.room} ${f.status}");
    }
    return filteredAmbients;
  }
}
