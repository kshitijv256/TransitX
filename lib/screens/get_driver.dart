import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transitx/main.dart';
import 'package:transitx/screens/add_transport.dart';
import 'package:transitx/screens/locator.dart';

class GetDriver extends StatefulWidget {
  const GetDriver({super.key});

  @override
  State<GetDriver> createState() => _GetDriverState();
}

class _GetDriverState extends State<GetDriver> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 19, 14),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Login"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTransport()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: controller,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Enter driver name",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 113, 23, 23), width: 3)),
                ),
                onChanged: (value) {
                  setState(() {
                    driver = value;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Locator()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.cyan[600],
                    gradient: LinearGradient(colors: [
                      Colors.red[400]!,
                      Colors.red[500]!,
                      Colors.red[700]!,
                      Colors.red[900]!
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('Start Tracking',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
