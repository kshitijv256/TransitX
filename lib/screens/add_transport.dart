import 'package:flutter/material.dart';

import '../services/crud.dart';

class AddTransport extends StatefulWidget {
  const AddTransport({super.key});

  @override
  State<AddTransport> createState() => _AddTransportState();
}

class _AddTransportState extends State<AddTransport> {
  final name = TextEditingController();
  final lat = TextEditingController();
  final long = TextEditingController();
  final type = TextEditingController();
  final route = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.addTransport(
              name: name.text,
              lat: double.parse(lat.text),
              long: double.parse(long.text),
              type: type.text,
              route: route.text,
            );
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transport'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextFormField(
              controller: lat,
              decoration: const InputDecoration(
                hintText: 'Latitude',
              ),
            ),
            TextFormField(
              controller: long,
              decoration: const InputDecoration(
                hintText: 'Longitude',
              ),
            ),
            TextFormField(
              controller: type,
              decoration: const InputDecoration(
                hintText: 'Type',
              ),
            ),
            TextFormField(
              controller: route,
              decoration: const InputDecoration(
                hintText: 'Route',
              ),
            ),
            SaveButon,
          ],
        ),
      ),
    );
  }
}
