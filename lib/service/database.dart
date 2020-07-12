import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testflutter/model/brew.dart';
import 'package:testflutter/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateuserdata(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      "name": name,
      "strength": strength,
    });
  }

//user data from snapshot
  Userdata _userdatafromSnapshot(DocumentSnapshot snapshot) {
    return Userdata(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? "",
        strength: doc.data["strength"] ?? 0,
        sugar: doc.data["sugar"] ?? "0",
      );
    }).toList();
  }

//get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<Userdata> get userData {
    return brewCollection.document(uid).snapshots().map(_userdatafromSnapshot);
  }
}
