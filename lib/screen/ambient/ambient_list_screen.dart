import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/ambient/ambient.dart';
import '../../models/ambient/ambient_services.dart';
import 'add_ambient_dialog.dart';

class AmbientListScreen extends StatelessWidget {
  const AmbientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AmbientServices ambientServices = AmbientServices();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text("Listagem de Ambientes ")),
      body: StreamBuilder<QuerySnapshot>(
        stream: ambientServices.getAmbients(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.only(left:30.0, right: 30.0),
              child: ListView.separated(
                itemCount: docSnap.length,
                itemBuilder: (context, index) {
                  String docId = docSnap[index].id;

                  Ambient cRooms = Ambient(
                    id: docSnap[index].id,
                    room: docSnap[index].get('room'),
                    status: docSnap[index].get('status'),
                  );

                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(docSnap[index].get('room')),
                                Text(docSnap[index].get('status')),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ), 
                         IconButton(
                              onPressed: () {
                                ambientServices.updateAmbient(cRooms);
                                debugPrint('entrup');
                                
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                ambientServices.deleteAmbient(docId);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))                     
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text("Dados não disponíveis");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addAmbient(context);
        },
        tooltip: 'Adicionar Ambientes',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addAmbient(context) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddAmbientDialog();
      },
    );
  }
}
