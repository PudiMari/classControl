
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/user_manager.dart';
import 'user_home_screen.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }
}

class TabPageState extends State<TabPage> {
  final List<String> _list = ['Informações Gerais'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _list.length,
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Olá, ${userManager.userLocal!.name} >",
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white)),
                centerTitle: true,
                bottom: TabBar(
                  isScrollable: false,
                  tabs: _list.map((String tabs) {
                    return Tab(text: tabs);
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  UserHomeScreen('Informações Gerais', userManager.userLocal!),
                  //const HomeList(),
                  //UserProfile('Acesso a Portaria'),
                ],
              ),
            );
          },
        ));
  }
}
