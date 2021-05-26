import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollections {
  static final _databaseRefrence = FirebaseFirestore.instance;

  // collection refrences for better scalibility

  final CollectionReference users = _databaseRefrence.collection('users');
  final CollectionReference rewards = _databaseRefrence.collection('rewards');
}
