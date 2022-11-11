
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/reserve/reserve2.dart';
import '../../models/reserve/reserve_services2.dart';
import 'reserve_card.dart';
import 'add_reserve_dialog.dart';

/* essa página fica e futuramente se transformará no cadastro e listagem de chamados

- tira a camera 
- 

*/

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final ReserveServices2 repository = ReserveServices2();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //backgroundColor: Colors.white,
        //title: const Text('Cadastro'),
      //),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getReserves(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReserve();
        },
        tooltip: 'Adicionar Cadastro',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addReserve() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddReserveDialog();
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
    final reserve = Reserve2.fromSnapshot(snapshot);
    return ReserveCard(reserve: reserve, boldStyle: boldStyle);
  }
}
