
import 'package:flutter/material.dart';

import '../../models/reserve/reserve2.dart';
import 'reserve_room.dart';

class ReserveCard extends StatelessWidget {
  final Reserve2 reserve;
  final TextStyle boldStyle;
  final splashColor = {
    'festa': Colors.pink[100],
    'cerimonial': Colors.blue[100],
    'outro': Colors.grey[100]
  };

  ReserveCard({Key? key, required this.reserve, required this.boldStyle})
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
              child: Text(reserve.name, style: boldStyle),
            ),
          ),
          _getAreaIcon(reserve.type)
        ],
      ),
      onTap: () => Navigator.push<Widget>(
        context,
        MaterialPageRoute(
          builder: (context) => ReserveRoom(reserve: reserve),
        ),
      ),
      splashColor: splashColor[reserve.type],
    ));
  }

  Widget _getAreaIcon(String type) {
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
