
import 'package:flutter/material.dart';

import '../reserve/home_list.dart';
import 'admin_page.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return AdminMainPageState();
  }
}

class AdminMainPageState extends State<AdminMainPage> {
  //final List<String> _list = ['Administração', 'Financeiro', 'Recicláveis'];
  final List<String> _list = ['Administração', 'EAR'];
  //final List<String> _list = ['Administração'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _list.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("EAR - Edição, Adição e Remoção",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: false,
            tabs: _list.map((String ss) {
              return Tab(text: ss);
            }).toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AdminMain('Ambiente'),
            //FinancialManagementPage('Gerência Financeira'),
            HomeList(),
          ],
        ),
      ),
    );
  }
}
