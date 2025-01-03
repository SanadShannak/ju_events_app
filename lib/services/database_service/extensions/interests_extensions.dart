import 'package:cloud_firestore/cloud_firestore.dart';

extension InterestsExtensions on FirebaseFirestore {
  Future<List<String>> fetchInterests() async {
    try {
      final DocumentSnapshot doc =
          await collection('interests').doc('interests').get();
      final data = doc.data() as Map<String, dynamic>;
      final List<String> interests = List<String>.from(data['titles']);

      return interests;
    } catch (e) {
      print('Error fetching interests: $e');
      return [];
    }
  }
}
