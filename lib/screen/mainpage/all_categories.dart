import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  AllCategories({Key? key}) : super(key: key);

  final List<String> images = [
    'assets/doodles/management.png',
    'assets/doodles/planner.png',
    'assets/doodles/qr_code.png',
    'assets/doodles/schedule.png',
  ];
  final List<String> types = [
    'Gerenciamento',
    'Planejamento',
    'Gerar QR-Code',
    'Reservas',
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
      ],
    );
  }

  banner() {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Carousel(
        dotBgColor: Colors.transparent,
        borderRadius: true,
        dotSize: 5,
        images: [
          Image.asset('assets/images/banner2.jpg'),
          Image.asset('assets/images/banner1.jpg'),
          Image.asset('assets/images/banner3.jpg'),
          // AssetImage('assets/images/banner1.png'),
        ],
      ),
    );
  }
}
