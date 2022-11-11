
import 'package:flutter/material.dart';

import 'financial_management_page.dart';
import 'user_profile.dart';

class UserTabScreen extends StatefulWidget {
  const UserTabScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return UserTabScreenState();
  }
}

class UserTabScreenState extends State<UserTabScreen> {
  List<String> _list = ['Encomendas', 'Reservas', 'Administração'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _list.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CondoApp",
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
        body: TabBarView(
          children: <Widget>[
            //  const UserHomeScreen('Controle de Encomendas'),
            const FinancialManagementPage('Gerenciamento de Reservas'),
            UserProfile('Administração')
          ],
        ),
      ),
    );
  }
}
