import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _UserCollection = _firestore.collection('User');
final CollectionReference _TranspCollection =
    _firestore.collection('Transport');

class FirebaseCrud {
  static Future<Response> addUser({
    required String name,
    required double lat,
    required double long,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "lat": lat,
      "long": long
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference notesItemCollection = _UserCollection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateUser({
    required String name,
    required double lat,
    required double long,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "lat": lat,
      "long": long
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated User";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

///////////////

  static Future<Response> addTransport({
    required String name,
    required double lat,
    required double long,
    required String type,
    required String route,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _TranspCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "lat": lat,
      "long": long,
      "type": type,
      "route": route
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readTransport() {
    CollectionReference notesItemCollection = _TranspCollection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateTransport({
    required String name,
    required double lat,
    required double long,
    required String type,
    required String route,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _TranspCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "lat": lat,
      "long": long,
      "type": type,
      "route": route
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Transport";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
