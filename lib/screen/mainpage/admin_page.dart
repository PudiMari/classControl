
import 'package:flutter/material.dart';


import '../ambient/ambient_list_screen.dart';
import '../dashboard/items_dashboard.dart';

class AdminMain extends StatefulWidget {
  final String title;
  const AdminMain(this.title, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminMainState();
  }
}

class AdminMainState extends State<AdminMain>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    super.build(context);
    /*ItemsDashboard item1 = ItemsDashboard(
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
    ); */

    ItemsDashboard item4 = ItemsDashboard(
      "Cadastro de Ambiente",
      "Playground - Salões de Festas",
      "assets/images/decor.jpg",
    );

    List<ItemsDashboard> myList = List.empty(growable: true);
   // myList.add(item1);
    //myList.add(item2);
    //myList.add(item3);
    myList.add(item4);
    return Scaffold(
      // backgroundColor: const Color(0xFFDADAD9),
      backgroundColor: const Color(0xFFEFF7F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myList.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: width / (height / 2),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => callCommand(context, index),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              myList[index].image,
                              height: 100,
                              width: 100,
                            ),
                            Text(myList[index].title),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                // scrollDirection: Axis.vertical,
              ),
              const SizedBox(height: 40.0),  
              // tira aquela barra azul com simbolo do flutter
              /*SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        height: 50.0,
                        color: Colors.green,
                        child: Image.network(
                          "https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png",
                          fit: BoxFit.fitWidth,
                          height: 120,
                        ),
                      ),
                    ); 
                  }, 
                  scrollDirection: Axis.horizontal,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  callCommand(BuildContext context, int index) {
    /*if (index == 0) {
      Navigator.of(context).pushNamed("/unit");
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CommomAreaListScreen(),
        ),
      );
    } */
    if (index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AmbientListScreen(),
        ),
      );
    }
  }
}
