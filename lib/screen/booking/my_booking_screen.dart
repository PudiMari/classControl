
import 'package:flutter/material.dart';

import '../../models/user/user.dart';

class MyBookingScreen extends StatelessWidget {
  UserLocal _userLocal;
  MyBookingScreen(this._userLocal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Adicionar Ambiente'),
        content: SingleChildScrollView(child: Container()));
  }
}
