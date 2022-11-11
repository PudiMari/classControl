//obter a instância do firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'book.dart';

class BookServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//método para persistir dados no firebase
  addBook(Book book) {
    _firestore.collection('booking').add(
          book.toMap(),
        );
  }

  Future<String> loadBooking(String id) async {
    var collection = _firestore.collection('booking');
    var docSnapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    // return '${data!['area']}';
    return Future.value(data!['area']);
  }

  ///método para obtenção de lista de dados das reservas
  Stream<QuerySnapshot> getBookingsList() {
    CollectionReference bookRef = _firestore.collection('booking');
    return bookRef.snapshots();
  }

//método para atualizar dados no firebase
  updateBook(
    String id,
    String ambientId,
    DateTime bookingDay,
    String unitId,
    String userId,
  ) {
    DocumentReference documentReference =
        _firestore.collection('booking').doc(id);
    Map<String, dynamic> data = <String, dynamic>{
      'ambientId': ambientId,
      'bookingDay': bookingDay,
      'unitId': unitId,
      'userId': userId,
    };
    documentReference
        .update(data)
        .whenComplete(
          () => debugPrint("Dados do $id atualizado com sucesso!!!"),
        )
        .catchError(
          (e) => debugPrint("Erro ao atualizar dados do $id -> $e!"),
        );
    ;
  }

//método para deletar dados no firebase
  deleteBook(String id) {
    DocumentReference documentReference =
        _firestore.collection('booking').doc(id);
    documentReference
        .delete()
        .whenComplete(
          () => debugPrint("Dados do $id deletado com sucesso!!!"),
        )
        .catchError(
          (e) => debugPrint("Erro ao deletar dados do $id -> $e!"),
        );
  }
}
