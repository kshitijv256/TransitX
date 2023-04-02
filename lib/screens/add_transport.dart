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
      borderRadius: BorderRadius.circular(10.0),
      color: Color.fromARGB(255, 125, 20, 20),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.9,
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
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 19, 14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Transport'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: name,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Name",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: lat,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Latitude",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: long,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Longitude",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: type,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Type",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: route,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Route",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
            ),
            SaveButon,
          ],
        ),
      ),
    );
  }
}
