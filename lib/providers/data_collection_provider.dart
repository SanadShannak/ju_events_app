import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/models/user_roles.dart';
import 'package:temp_project/services/database_service/extensions/institutional_unit_extensions.dart';

class DataCollectionProvider extends ChangeNotifier {
  String? name;
  String? selectedCollege;
  String? selectedCollegeId;
  String? selectedMajor;
  List<String>? selectedInterests;
  Set<int> selectedInterestIndices = {}; // For Interest Coloring Management
  UserRole userRole = UserRole.normalUser;

  bool get isNameValid => name != null && name!.isNotEmpty;
  bool get isCollegeMajorValid =>
      selectedCollege != null && selectedMajor != null;
  bool get areInterestsValid =>
      selectedInterests != null && selectedInterests!.isNotEmpty;

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateCollege(String? college) {
    selectedCollege = college;
    updateCollegeId(college);
    notifyListeners();
  }

  Future<void> updateCollegeId(String? collegeName) async {
    selectedCollegeId =
        await FirebaseFirestore.instance.getCollegeIdByName(collegeName!);
    notifyListeners();
  }

  void updateMajor(String? major) {
    selectedMajor = major;
    notifyListeners();
  }

  void updateInterests(List<String> interests) {
    selectedInterests = interests;
    notifyListeners();
  }

  void addInterest(String interest) {
    selectedInterests ??=
        []; // checks if selectedInterests is null and assigns an empty list if it is
    selectedInterests!.add(interest);
    notifyListeners();
  }

  void removeInterest(String interest) {
    if (selectedInterests == null) {
      return;
    }
    selectedInterests!.remove(interest);
    notifyListeners();
  }

  void resetDataToNull() {
    name = null;
    selectedCollege = null;
    selectedMajor = null;
    selectedInterests = [];
    selectedInterestIndices.clear();
    notifyListeners();
  }
}
