import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: TabBar(
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorColor: Colors.red,
                labelColor: Colors.red,
                tabs: [
                  Text('Amber'),
                  Text('Blue'),
                  Text('Orange'),
                  Text('Green'),
                ]),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.amberAccent,
                ),
                Container(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.orangeAccent,
                ),
                Container(
                  color: Colors.greenAccent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
