
import 'package:flutter/material.dart';

import '../../models/units/unit.dart';
import '../../models/units/unit_services.dart';

class UnitAddScreen extends StatelessWidget {
  UnitAddScreen({Key? key}) : super(key: key);

  TextEditingController unitController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Moradores"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Unidade'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: unitController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.orangeAccent,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha o campo nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Proprietário'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ownerController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.orangeAccent,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'favor preencher o campo do proprietário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  UnitServices unitServices = UnitServices();
                  Unit unit = Unit(unitController.text, []);
                  unitServices.addUnit(unit);
                }
              },
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}
