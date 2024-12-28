import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user.dart';
import '../../auth_service.dart';
import '../database_service.dart';

extension UserExtensions on DatabaseService {
  /// Creates a new user record in the 'users' collection.
  Future<OperationStatus> createUserRecord(User user) async {
    final String? userId = AuthService.instance.getUserId();
    try {
      if (userId != null) {
        await refs[CollectionRefs.users]!.doc(userId).set({'full_name': 'osama'}, SetOptions(merge: true));
        return OperationStatus.success;
      } else {
        return OperationStatus.failure;
      }
    } catch (e) {
      print('Error creating user record: $e');
      return OperationStatus.failure;
    }
  }
}
