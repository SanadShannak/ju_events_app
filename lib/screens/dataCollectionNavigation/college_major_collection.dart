import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/providers/data_collection_provider.dart';

import 'package:temp_project/screens/dataCollectionNavigation/components/drop_down_menu_widget.dart';
import 'package:temp_project/services/database_service/extensions/institutional_unit_extensions.dart';
import 'package:temp_project/utilities/constants.dart';

class CollegeMajorCollection extends StatefulWidget {
  const CollegeMajorCollection({super.key});

  @override
  State<CollegeMajorCollection> createState() => _CollegeMajorCollectionState();
}

class _CollegeMajorCollectionState extends State<CollegeMajorCollection> {
  final GlobalKey<FormFieldState<String>> _collegeFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _majorFieldKey =
      GlobalKey<FormFieldState<String>>();
  Map<String, List<String>> collegeMajorMap = {};
  List<String> colleges = [];
  String? selectedCollege;
  String? selectedMajor;
  @override
  void initState() {
    super.initState();
    fetchCollegesAndMajors();
  }

  Future<void> fetchCollegesAndMajors() async {
    try {
      final fetchedCollegeMajorMap =
          await FirebaseFirestore.instance.fetchCollegesAndMajors();
      setState(() {
        collegeMajorMap = fetchedCollegeMajorMap;
        colleges = collegeMajorMap.keys.toList();
      });
    } catch (e) {
      print('Error fetching colleges and majors: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? savedCollege =
        Provider.of<DataCollectionProvider>(context, listen: true)
            .selectedCollege;
    String? savedMajor =
        Provider.of<DataCollectionProvider>(context, listen: true)
            .selectedMajor;
    List<String> majors =
        selectedCollege != null ? collegeMajorMap[selectedCollege!]! : [];
    List<DropdownMenuItem<String>> collegeDropdownMenuEntries = colleges
        .map((college) => DropdownMenuItem(
              value: college,
              child: SizedBox(
                width: size.width * .7,
                child: Text(
                  college,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ))
        .toList();
    List<DropdownMenuItem<String>> majorDropDownMenuEntries = majors
        .map((major) => DropdownMenuItem(
              value: major,
              child: SizedBox(
                  width: size.width * .7,
                  child: Text(
                    major,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )),
            ))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 170,
            ),
            const Text(
              'Please Select your College and Major',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kDarkGreen),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: size.width * .9,
                child: CustomDropDownMenuWidget(
                  dropDownMenuKey: _collegeFieldKey,
                  dropDownMenuEntries: collegeDropdownMenuEntries,
                  dropDownMenuValue: selectedCollege,
                  dropDownMenuOnChanged: (college) {
                    setState(() {
                      selectedCollege = college;
                      selectedMajor = null;
                      context
                          .read<DataCollectionProvider>()
                          .updateCollege(college);
                      context
                          .read<DataCollectionProvider>()
                          .updateMajor(selectedMajor);
                    });
                    _collegeFieldKey.currentState?.validate();
                  },
                  dropDownMenuValidator: (college) {
                    if (college == null) {
                      return "Please select your college";
                    }
                    return null;
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return colleges.map((college) {
                      return SizedBox(
                        width: size.width * .7,
                        child: Text(
                          college,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList();
                  },
                  formLabel: 'College',
                )),
            const SizedBox(
              height: 75,
            ),
            SizedBox(
                width: size.width * .9,
                child: CustomDropDownMenuWidget(
                  dropDownMenuKey: _majorFieldKey,
                  dropDownMenuEntries: majorDropDownMenuEntries,
                  dropDownMenuValue: selectedMajor,
                  dropDownMenuOnChanged: (major) {
                    setState(() {
                      selectedMajor = major;
                      context.read<DataCollectionProvider>().updateMajor(major);
                    });
                    _majorFieldKey.currentState?.validate();
                  },
                  dropDownMenuValidator: (major) {
                    if (major == null) {
                      return 'Please select your major';
                    }
                    return null;
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return majors.map((major) {
                      return SizedBox(
                        width: size.width * .7,
                        child: Text(
                          major,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList();
                  },
                  formLabel: 'Major',
                )),
          ],
        ),
      ),
    );
  }
}
