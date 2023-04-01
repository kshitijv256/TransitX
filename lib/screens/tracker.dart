import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracker'),
      ),
      body: Column(
        children: [
          Text("Normal User"),
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
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['lat'].toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['long'].toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['type'].toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['route'].toString()),
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
                    );
                  });
            },
          )),
        ],
      ),
    );
  }
}
