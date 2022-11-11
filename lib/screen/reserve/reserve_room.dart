
import 'package:flutter/material.dart';

import '../../models/reserve/reserve2.dart';
import 'reserve_details.dart';

class ReserveRoom extends StatelessWidget {
  final Reserve2 reserve;

  const ReserveRoom({Key? key, required this.reserve}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(reserve.name),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ReserveDetail(reserve: reserve),
      ),
    );
  }
}
