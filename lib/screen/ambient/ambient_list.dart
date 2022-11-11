import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/ambient/ambient.dart';
import '../../models/ambient/ambient_services.dart';
import 'add_ambient_dialog.dart';
import 'ambient_card.dart';

class AmbientList extends StatefulWidget {
  const AmbientList({Key? key}) : super(key: key);
  @override
  _AmbientListState createState() => _AmbientListState();
}

class _AmbientListState extends State<AmbientList> {
  final AmbientServices repository = AmbientServices();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro dos Ambientes...'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getAmbients(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            return _buildList(context, snapshot.data?.docs ?? []);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addAmbient();
        },
        tooltip: 'Adicionar Áreas Comuns',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addAmbient() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddAmbientDialog();
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final ambient = Ambient.fromSnapshot(snapshot);
    return AmbientCard(ambient: ambient, boldStyle: boldStyle);
  }
}
