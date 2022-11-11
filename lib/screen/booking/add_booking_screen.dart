
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ambient/ambient_services.dart';
import '../../models/booking/book.dart';
import '../../models/booking/book_services.dart';
import '../../models/user/user.dart';
import '../reserve/widgets/date_picker.dart';
import '../reserve/widgets/user_text_field.dart';

class AddBookingScreen extends StatefulWidget {
  UserLocal _userLocal;
  AddBookingScreen(this._userLocal, {Key? key}) : super(key: key);
  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  var selectedItemRoom, selectedType;
  var selectedRoom;
  final dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime roomDate;
  late String description;

  String roomId = '';
  var roomC;
  var setDefaultRoom = true;

  @override
  Widget build(BuildContext context) {
    // CommomArea? commomArea = CommomArea();
    AmbientServices ambientServices = AmbientServices();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cadastro de Ambiente',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text('Sala'),
                StreamBuilder<QuerySnapshot>(
                    stream: ambientServices.getAmbients(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DropdownMenuItem<String>> roomItems = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data!.docs[i];
                          roomItems.add(
                            DropdownMenuItem<String>(
                              child: Text(
                                snap.get('area'),
                                style:
                                    const TextStyle(color: Color.fromARGB(255, 152, 18, 18)),
                              ),
                              // onTap: _onTapped(snap.get('area')),
                              value: snap.id,
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(width: 50.0),
                            DropdownButton(
                              items: roomItems,
                              onChanged: (value) {
                                _onTapped(value.toString());
                                
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Ambiente atual é $value',
                                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedItemRoom = value;
                                  roomId = value.toString();
                                  debugPrint(
                                      "Sala selecionada $selectedItemRoom");
                                });
                              },
                              value: selectedItemRoom,
                              isExpanded: false,
                              hint: const Text(
                                "Escolha a sala para agendamento",
                                style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
                              ),
                              ),   
                          ],
                        );
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: DatePicker(
                    name: 'Data da reserva',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a data da reserva';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (data) {
                      roomDate = data;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Column(
                    children: <Widget>[
                      UserTextField(
                        name: 'Descrição',
                        initialValue: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe descrição de uso da sala';
                          }
                        },
                        inputType: TextInputType.text,
                        onChanged: (value) {
                          if (value != null) {
                            description = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                            onPressed: () {
                              // _onTapped(areaC);
                              if (_formKey.currentState?.validate() ?? false) {
                                Navigator.of(context).pop();
                                final book = Book(
                                    bookingDay: roomDate,
                                    ambientId: roomId,
                                    unitId: description,
                                      userId: widget._userLocal.id!);
                                BookServices bookServices = BookServices();
                                bookServices.addBook(book);
                              }
                            },
                            child: const Text('Adicionar')),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _onTapped(String id) {
    debugPrint("onTapped --> $id");
    roomId = id;
  }

  String getTime(var time) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy, hh:mm:ss aa');
    var date = time.toDate();
    return formatter.format(date);
  }
}
