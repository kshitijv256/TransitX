import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'map.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 19, 14),
      appBar: AppBar(
        title: const Text('Available Transport'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Map()));
        },
        child: Icon(Icons.map),
        backgroundColor: Colors.red[700],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Transport').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 174, 43, 43),
                            Color.fromARGB(255, 152, 31, 31),
                            Color.fromARGB(255, 121, 17, 17),
                            Color.fromARGB(255, 85, 6, 6),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text(
                          "Driver Name: " +
                              snapshot.data!.docs[index]['name'].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Transportation type: " +
                                    snapshot.data!.docs[index]['type']
                                        .toString(),
                                style: TextStyle(color: Colors.grey[300])),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                "Route No: " +
                                    snapshot.data!.docs[index]['route']
                                        .toString(),
                                style: TextStyle(color: Colors.grey[300])),
                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.directions),
                        //   onPressed: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             MyMap(snapshot.data!.docs[index].id)));
                        //   },
                        // ),
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }
}
