
import 'package:flutter/material.dart';

import 'items_dashboard.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  ItemsDashboard item1 = ItemsDashboard(
    "Unidades",
    "Casa dos Moradores",
    "assets/images/home.png",
  );

  ItemsDashboard item2 = ItemsDashboard(
    "Usuários",
    "Registro de Usuários",
    "assets/images/persons.png",
  );

  ItemsDashboard item3 = ItemsDashboard(
    "Encomendas",
    "Entrega das Encomendas",
    "assets/images/map.png",
  );

  @override
  Widget build(BuildContext context) {
    List<ItemsDashboard> myList = [item1, item2, item3];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
          itemCount: myList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () => callUnit(ctx, index),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    Image.asset(myList[index].image),
                    Text(myList[index].title),
                  ],
                ),
              ),
            );
          }),
    );
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed("/unit");
    }
  }
}
