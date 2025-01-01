import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event.dart';
import '../../models/institutional_unit.dart';
import '../../models/requested_event.dart';
import '../../models/team.dart';
import '../../models/user.dart';

/// Enum representing different Firestore collection references.
enum CollectionRefs {
  users('users'),
  events('events'),
  requestedEvents('requested_events'),
  teams('teams'),
  institutionalUnits('institutional_units'),
  interests('interests');

  final String ref;
  const CollectionRefs(this.ref);
}

/// Enum representing the status of Firestore operations.
enum OperationStatus {
  success,
  failure,
  documentNotFound,
  invalidData,
  unknownError;
}

/// Service class for interacting with Firestore.
///
/// This class provides core functionalities for interacting with Firestore,
/// such as CRUD operations. For additional features like filtering and pagination,
/// you can create extension ( extensions folder ) or directly access the `refs` map.
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal() {
    _initializeRefs();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<CollectionRefs, CollectionReference> refs = {};

  /// Initializes Firestore collection references with converters.
  void _initializeRefs() {
    _initializeCollectionRef<User>(CollectionRefs.users, User.fromJson, (user) => user.toJson());
    _initializeCollectionRef<Event>(CollectionRefs.events, Event.fromJson, (event) => event.toJson());
    _initializeCollectionRef<InstitutionalUnit>(
        CollectionRefs.institutionalUnits, InstitutionalUnit.fromJson, (unit) => unit.toJson());
    _initializeCollectionRef<RequestedEvent>(
        CollectionRefs.requestedEvents, RequestedEvent.fromJson, (rEvent) => rEvent.toJson());
    _initializeCollectionRef<Team>(CollectionRefs.teams, Team.fromJson, (team) => team.toJson());
    refs[CollectionRefs.interests] = _firestore.collection(CollectionRefs.interests.ref);
  }

  /// Initializes a collection reference with a Firestore data converter.
  void _initializeCollectionRef<T>(
    CollectionRefs ref,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> Function(T) toJson,
  ) {
    refs[ref] = _firestore.collection(ref.ref).withConverter<T>(
          fromFirestore: (snapshot, options) => fromJson(snapshot.data()!),
          toFirestore: (data, options) => toJson(data),
        );
  }

  /// Returns a stream of query snapshots for a given collection reference.
  Stream<QuerySnapshot> getCollectionStream(CollectionRefs ref) {
    return refs[ref]!.snapshots();
  }

  /// Retrieves all documents from a given collection reference.
  Future<QuerySnapshot> getAllDocuments(CollectionRefs ref) async {
    try {
      return await refs[ref]!.get();
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
  }

  /// Retrieves a specific document from a given collection reference by document ID.
  Future<DocumentSnapshot?> getDocument(CollectionRefs ref, String documentId) async {
    try {
      final doc = await refs[ref]!.doc(documentId).get();
      return doc.exists ? doc : null;
    } catch (e) {
      print('Error getting document: $e');
      rethrow;
    }
  }

  /// Adds a new document to a given collection reference.
  Future<OperationStatus> addDocument<T>(CollectionRefs ref, T data) async {
    try {
      await refs[ref]!.add(data);
      return OperationStatus.success;
    } catch (e) {
      print('Error adding document: $e');
      return OperationStatus.failure;
    }
  }

  /// Updates an existing document in a given collection reference.
  Future<OperationStatus> updateDocument<T>(
      CollectionRefs ref, String documentId, T data, Map<String, dynamic> Function(T) toJson) async {
    try {
      await refs[ref]!.doc(documentId).update(toJson(data));
      return OperationStatus.success;
    } catch (e) {
      print('Error updating document: $e');
      return OperationStatus.failure;
    }
  }

  /// Deletes a document from a given collection reference.
  Future<OperationStatus> deleteDocument(CollectionRefs ref, String documentId) async {
    try {
      await refs[ref]!.doc(documentId).delete();
      return OperationStatus.success;
    } catch (e) {
      print('Error deleting document: $e');
      return OperationStatus.failure;
    }
  }

  /// Retrieves a list of interests from the 'interests' collection.
  Future<List<String>> getInterests() async {
    try {
      final doc = await refs[CollectionRefs.interests]!.doc('interests').get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        return List<String>.from(data['titles'] ?? []);
      }
      return [];
    } catch (e) {
      print('Error fetching interests: $e');
      return [];
    }
  }
}
