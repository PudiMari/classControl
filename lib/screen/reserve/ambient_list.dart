
import 'package:flutter/material.dart';

import '../../models/reserve/ambient2.dart';
import '../../models/reserve/reserve2.dart';

class AmbientList extends StatelessWidget {
  final Reserve2 reserve;
  final Widget Function(Ambient2) buildRow;
  const AmbientList(
      {Key? key, required this.reserve, required this.buildRow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 6.0),
        const Text(
          'Ambientes',
          style: TextStyle(fontSize: 16.0),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: reserve.rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return buildRow(reserve.rooms[index]);
            },
          ),
        ),
      ],
    );
  }
}
