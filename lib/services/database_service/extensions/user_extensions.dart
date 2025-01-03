import '../../../models/user.dart';
import '../../auth_service.dart';
import '../database_service.dart';

const requiredFields = ['full_name', 'major_field', 'unit_id', 'unit_name', 'user_role'];

//TODO: This is just an example of usage
// Indicator of the users' collection operation status
enum UserOperationStatus {
  successfulOperation,
  noUserId, // the user Id is not found in Auth Service
  documentDoesNotExist, // user document or record doesn't exist
  missingFields, // missing required field(s) in user record
  unexpectedError,
}

extension UserExtensions on DatabaseService {
  /// Creates a new user record in the 'users' collection.
  Future<OperationStatus> createUserRecord(User user) async {
    final String? userId = AuthService.instance.getUserId();
    try {
      if (userId != null) {
        await refs[CollectionRefs.users]!.doc(userId).set(user);
        return OperationStatus.success;
      } else {
        return OperationStatus.failure;
      }
    } catch (e) {
      print('Error creating user record: $e');
      return OperationStatus.failure;
    }
  }

  /// Checks if all required fields exist in the user's document.
  Future<UserOperationStatus> areRequiredFieldsExist() async {
    final String? userId = AuthService.instance.getUserId();
    if (userId == null) {
      return UserOperationStatus.noUserId; // No user ID means no document to check.
    }

    try {
      final userDoc = await DatabaseService().getDocument(CollectionRefs.users, userId);

      if (userDoc == null) {
        return UserOperationStatus.documentDoesNotExist; // Document does not exist.
      }

      final userData = userDoc.data() as Map;

      // Check if all required fields exist and are not null.
      for (final field in requiredFields) {
        if (userData[field] == null) {
          return UserOperationStatus.missingFields; // Field is missing or null.
        }
      }

      return UserOperationStatus.successfulOperation; // All required fields exist.
    } catch (e) {
      print('Error checking required fields: $e');
      return UserOperationStatus.unexpectedError;
    }
  }
}
