// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../models/user/user.dart';
import '../booking/booking_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final String title;
  final UserLocal _userLocal;
  const UserHomeScreen(this.title, this._userLocal, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return UserHomeScreenState();
  }
}

class UserHomeScreenState extends State<UserHomeScreen>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // backgroundColor: const Color(0xFFDADAD9),
      backgroundColor: const Color(0xFFEFF7F6),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Reservas",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              BookingScreen(widget._userLocal),
              /*MaterialButton(
                child: Text(widget.title + ":$_count"),
                onPressed: addAction,
              ),
              MaterialButton(
                child: const Text("Acessar"),
                color: Colors.pinkAccent,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewPage();
                  }));
                },
              )*/
            ],
          ),
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
