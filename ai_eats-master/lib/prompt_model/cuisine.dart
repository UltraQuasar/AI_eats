
import 'package:cloud_firestore/cloud_firestore.dart';



class Cuisine {
  final String name;
  final String image_path;
  Cuisine({
    required this.name,
    required this.image_path
  });

  factory Cuisine.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
  return Cuisine(name: data['cuisine'], image_path: data['image_path']);
  }
}