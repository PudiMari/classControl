
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ambient/ambient.dart';
import '../../models/ambient/ambient_services.dart';
import '../../models/booking/book_services.dart';
import '../../models/user/user.dart';
import 'add_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  final UserLocal _userLocal;
  const BookingScreen(this._userLocal, {Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  AmbientServices ambientServices = AmbientServices();
  BookServices bookServices = BookServices();

  List<Ambient> listRooms = [];
  var isLoad = true;
  String? room;

  getListAreas() {
    ambientServices.getDocs();
    List<Ambient> listAuxRooms = ambientServices.allAmbient;
    // setState(() {
    listRooms = listAuxRooms;
    // });
  }

  @override
  void initState() {
    getListAreas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    DateTime? _selectedDate;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // banner(),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  // width: MediaQuery.of(context).size.width * .8,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.none), //Border.all

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor: const Color(0xFFEFF7F6),
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed("/booking");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddBookingScreen(widget._userLocal)));
                          },
                          child: const Text("Fazer reserva")),
                      /*OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.blue,
                            backgroundColor: const Color(0xFFEFF7F6),
                          ),
                          onPressed: () {},
                          child: const Text("Minhas Reservas")),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.blue,
                            backgroundColor: const Color(0xFFEFF7F6),
                          ),
                          onPressed: () {},
                          child: const Text("Cancelar Reservas")) */
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    color: const Color.fromARGB(255, 181, 185, 185),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: bookServices.getBookingsList(),
                        builder: (BuildContext context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            List<DocumentSnapshot> docSnap =
                                snapshot.data!.docs;
                            return SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 5,
                                                bottom: 5),
                                            width: 120.0,
                                            child: const Text(
                                              "Data",
                                            )),
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 5,
                                                bottom: 5),
                                            width: 200.0,
                                            child: const Text(
                                              "Local",
                                            )),
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 5,
                                                bottom: 10),
                                            child: const Text(
                                              "Descrição",
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: docSnap.length,
                                      itemBuilder: (context, index) {
                                        loadArea(
                                          docSnap[index].get('ambientId'),
                                        );
                                        _selectedDate = (docSnap[index]
                                            .get('bookingDay')
                                            .toDate());
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(_selectedDate!),
                                                    // _selectedDate.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 180,
                                                    child: RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 12.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        text: room,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    docSnap[index]
                                                        .get('unitId'),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Text("Dados não disponíveis");
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  setArea(String room) {
    this.room = room;
    debugPrint("SetArea-> $room");
  }

  loadArea(String id) {
    getListAreas();
    for (int i = 0; i < listRooms.length; i++) {
      if (listRooms[i].id == id) {
        room = listRooms[i].room;
        debugPrint("área encontrada =--> ${listRooms[i].id} - $room ");
      }
    }
  }
}
