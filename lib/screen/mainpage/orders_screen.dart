import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final List<String> images = [
    'assets/doodles/packaging_80.png',
    'assets/doodles/unpacking_80.png',
  ];
  final List<String> types = [
    'Recebimento',
    'Entrega',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Column(
      children: [
        // banner(),
        const SizedBox(
          height: 10,
        ),
        Card(
          elevation: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 10,
              childAspectRatio: (itemWidth / itemHeight) * 1.5,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(types.length, (index) {
                return Column(
                  children: [
                    Container(
                      height: itemHeight / 4.0,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4.0)),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(images[index]))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      types[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid), //Border.all

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            child: const Text(
              "Ocorrências",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
