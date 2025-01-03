import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user.dart';
import '../database_service.dart';

extension EventExtensions on DatabaseService {
  Future<QuerySnapshot?> getMatchingEvents(String userId) async {
    // Step 1: Get the user's interests
    DocumentSnapshot<Object?>? userDoc = await DatabaseService().getDocument(CollectionRefs.users, userId);

    if (userDoc != null) {
      List<String> userInterests = (userDoc.data() as User).interests;
      // Step 2: Query the events collection where 'topics' contain any of the user's interests
      QuerySnapshot<Object?>? eventsQuery =
          await refs[CollectionRefs.events]?.where('topics', arrayContainsAny: userInterests).get();

      // Return the QuerySnapshot directly
      return eventsQuery;
    }
    return null;
  }

  Future<QuerySnapshot> getEventsByInstitutionalUnit(String instUnit) async {
    try {
      return await refs[CollectionRefs.events]!.where('location_info', isEqualTo: instUnit).get();
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot?> getEventsByDate(DateTime date) async {
    // Construct the start and end strings for the target date
    String startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0).toIso8601String();
    String endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999).toIso8601String();

    // Query Firestore for events within the specified date range
    return refs[CollectionRefs.events]!
        .where('date_time', isGreaterThanOrEqualTo: startOfDay)
        .where('date_time', isLessThanOrEqualTo: endOfDay)
        .get();
  }
}
