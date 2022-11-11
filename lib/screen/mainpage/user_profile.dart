// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'all_categories.dart';

class UserProfile extends StatefulWidget {
  String title;
  UserProfile(this.title, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(title: const Text("Administração Condominial")),
      body: Column(
        children: <Widget>[
          AllCategories(),
          MaterialButton(
            child: Text(widget.title),
            onPressed: addAction,
          ),
          MaterialButton(
            child: const Text("Botão"),
            color: Colors.pinkAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewPage();
              }));
            },
          )
        ],
      ),
    );
  }

  void addAction() {
    setState(() {
      _count++;
    });
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retornando dados (ex.)'),
      ),
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Escolha uma das opções!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the
  // result from Navigator.pop.
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$result',
          style: const TextStyle(fontSize: 11),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha uma opção'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Acertou!!!!');
                },
                child: const Text('Boa escolha!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Errou!!!!');
                },
                child: const Text('Escolha Negada.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
