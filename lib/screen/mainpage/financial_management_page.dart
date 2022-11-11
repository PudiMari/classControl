
import 'package:flutter/material.dart';

import 'page4.dart';

class FinancialManagementPage extends StatefulWidget {
  final String title;
  const FinancialManagementPage(this.title, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FinancialManagementPageState();
  }
}

class FinancialManagementPageState extends State<FinancialManagementPage>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      ),
    );
  }

  void addAction() {
    setState(() {
      _count++;
    });
  }
}
