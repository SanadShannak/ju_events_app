import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/services/database_service/database_service.dart';

extension EventExtensions on DatabaseService {
  Future<String?> getCurrentUserTeamId() async {
    final String? userId = AuthService.instance.getUserId();
    if (userId != null) {
      DocumentSnapshot<Object?>? userDoc =
          await DatabaseService().getDocument(CollectionRefs.users, userId);
      if (userDoc != null && userDoc['user_role'] == 'team_leader') {
        QuerySnapshot querySnapshot = await refs[CollectionRefs.teams]!
            .where('leader_id', isEqualTo: userId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String teamId = querySnapshot.docs.first.id;
          return teamId;
        } else {
          return null;
        }
      }
    }
    return null;
  }

  Future<String?> getCurrentUserUnitId() async {
    final String? userId = AuthService.instance.getUserId();
    if (userId != null) {
      DocumentSnapshot<Object?>? userDoc =
          await DatabaseService().getDocument(CollectionRefs.users, userId);

      if (userDoc != null) {
        String unitId = userDoc.get('unit_id');
        return unitId;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<QuerySnapshot> getRequestedEventsByCurrentUserTeam() async {
    final String? teamId = await getCurrentUserTeamId();
    try {
      if (teamId != null) {
        QuerySnapshot querySnapshot =
            await refs[CollectionRefs.requestedEvents]!
                .where('posted_by_id', isEqualTo: teamId)
                .get();
        return querySnapshot;
      }
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
    throw {print('Error getting documents')};
  }

  Future<QuerySnapshot> getPendingEventsToCurrentUser() async {
    final String? adminUnitId = await getCurrentUserUnitId();
    final String? userId = AuthService.instance.getUserId();
    try {
      if (adminUnitId != null) {
        QuerySnapshot querySnapshot =
            await refs[CollectionRefs.requestedEvents]!
                .where('target_id', isEqualTo: userId)
                .where('request_state', isEqualTo: 'pending')
                .get();
        return querySnapshot;
      }
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
    throw {print('Error getting documents')};
  }

  Future<void> updateRequestedEventState(
      String eventId, String newState) async {
    await FirebaseFirestore.instance
        .collection('requested_events')
        .doc(eventId)
        .update({'request_state': newState});
  }

  Future<void> removeEventFromRequestedEvents(String eventId) async {
    await FirebaseFirestore.instance
        .collection('requested_events')
        .doc(eventId)
        .delete();
  }
}
