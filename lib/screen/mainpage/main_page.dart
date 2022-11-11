
import 'package:flutter/material.dart';

import 'admin_main_page.dart';
import 'client_main_screen.dart';
import 'user_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [];

  List<BottomNavigationBarItem> getItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Início",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Cadastro de Ambiente (e talvez usuario)",
      ),
      /*const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Perfil",
      ), */
    ];
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;

    _pages.add(const TabPage(
      title: "Informações Gerais  ",
    ));
    _pages.add(const AdminMainPage(title: 'Administração geral'));
    _pages.add(UserProfile("Perfil do usuário"));
  }

  @override
  Widget build(BuildContext context) {
    // if (_isConnected) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE5EBEA),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: getItems(),
        onTap: onTabTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
