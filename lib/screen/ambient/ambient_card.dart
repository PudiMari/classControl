
import 'package:flutter/material.dart';

import '../../models/ambient/ambient.dart';

class AmbientCard extends StatelessWidget {
  final Ambient ambient;
  final TextStyle boldStyle;
  final splashColor = {
    'festa': Colors.pink[100],
    'cerimonial': Colors.blue[100],
    'outro': Colors.grey[100]
  };

  AmbientCard({Key? key, required this.ambient, required this.boldStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(ambient.room!, style: boldStyle),
            ),
          ),
        ],
      ),
      onTap: () {},
    ));
  }

  Widget _getRoomIcon(String type) {
    Widget condoIcon;
    if (type == 'festa') {
      condoIcon = IconButton(
        icon: const Icon(
          Icons.party_mode,
          color: Colors.pinkAccent,
        ),
        onPressed: () {},
      );
    } else if (type == 'cerimonial') {
      condoIcon = IconButton(
        icon: const Icon(
          Icons.celebration,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      );
    } else {
      condoIcon = IconButton(
        icon: const Icon(
          Icons.other_houses,
          color: Colors.blueGrey,
        ),
        onPressed: () {},
      );
    }
    return condoIcon;
  }
}
