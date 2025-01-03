import 'package:cloud_firestore/cloud_firestore.dart';

extension InstitutionalUnitExtensions on FirebaseFirestore {
  Future<Map<String, List<String>>> fetchCollegesAndMajors() async {
    try {
      final QuerySnapshot snapshot =
          await collection('institutional_units').get();
      final Map<String, List<String>> collegesAndMajors = {};

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final String unitName = data['unit_name'];
        final List<String> majorsList = List<String>.from(data['majors_list']);

        collegesAndMajors[unitName] = majorsList;
      }

      return collegesAndMajors;
    } catch (e) {
      print('Error fetching colleges and majors: $e');
      return {};
    }
  }

  Future<String?> getCollegeIdByName(String collegeName) async {
    try {
      final QuerySnapshot snapshot = await collection('institutional_units')
          .where('unit_name', isEqualTo: collegeName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }

      return null; // Return Null if no matching college is found
    } catch (e) {
      print('Error fetching college id by name: $e');
      return null;
    }
  }
}
