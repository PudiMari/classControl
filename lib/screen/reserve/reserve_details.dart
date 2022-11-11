
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../models/reserve/ambient2.dart';
import '../../models/reserve/reserve2.dart';
import '../../models/reserve/reserve_services2.dart';
import 'add_ambient.dart';
import 'ambient_list.dart';
import 'widgets/choose_chips.dart';
import 'widgets/user_text_field.dart';

class ReserveDetail extends StatefulWidget {
  final Reserve2 reserve;

  const ReserveDetail({Key? key, required this.reserve}) : super(key: key);

  @override
  _ReserveDetailState createState() => _ReserveDetailState();
}

class _ReserveDetailState extends State<ReserveDetail> {
  final ReserveServices2 repository = ReserveServices2();
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late List<CategoryOption> areaTypes;
  late String name;
  late String type;
  String? notes;

  @override
  void initState() {
    type = widget.reserve.type;
    name = widget.reserve.name;
    areaTypes = [
      CategoryOption(type: 'festa', name: 'Festa', isSelected: type == 'festa'),
      CategoryOption(
          type: 'cerimonial',
          name: 'Cerimonial',
          isSelected: type == 'cerimonial'),
      CategoryOption(type: 'outro', name: 'Outro', isSelected: type == 'outro'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: double.infinity,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Local',
                initialValue: widget.reserve.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor entre com o nome';
                  }
                },
                inputType: TextInputType.name,
                onChanged: (value) => name = value ?? name,
              ),
               const SizedBox(height: 20.0),
              UserTextField(
                name: 'Descrição',
                initialValue: widget.reserve.notes ?? '',
                validator: (value) {},
                inputType: TextInputType.text,
                onChanged: (value) => notes = value,
              ),
              FloatingActionButton(
                onPressed: () {
                  
                  // cata aquela função do dropbox
                  _addCommonArea(widget.reserve, () {
                    setState(() {});
                  });
                },
                tooltip: 'Adicionar Ambiente',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.of(context).pop();
                        repository.deleteReserve(widget.reserve);
                      },
                      child: const Text(
                        'Deletar',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )),
                  MaterialButton(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        widget.reserve.name = name;
                        widget.reserve.type = type;
                        widget.reserve.notes = notes ?? widget.reserve.notes;

                        repository.updateReserve(widget.reserve);
                      }
                    },
                    child: const Text(
                      'Atualizar',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(Ambient2 ambient) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(ambient.room),
        ),
        Text(dateFormat.format(ambient.date)),
        Checkbox(
          value: ambient.done ?? false,
          onChanged: (value) {
            setState(() {
              ambient.done = value;
            });
          },
        )
      ],
    );
  }

  void _addCommonArea(Reserve2 reserve, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddAmbient(reserve: reserve, callback: callback);
        });
  }
}
