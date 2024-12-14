import 'package:flutter/material.dart';
import 'package:temp_project/screens/dataCollection/components/data_collection_widget.dart';
import 'package:temp_project/screens/dataCollection/interests_collection.dart';
import 'package:temp_project/screens/dataCollection/name_collection.dart';
import 'package:temp_project/utilities/constants.dart';

class TestCollegeMajorCollection extends StatefulWidget {
  const TestCollegeMajorCollection({super.key});

  @override
  State<TestCollegeMajorCollection> createState() =>
      _TestCollegeMajorCollectionState();
}

class _TestCollegeMajorCollectionState
    extends State<TestCollegeMajorCollection> {
  final GlobalKey<FormState> _collegeMajorFormKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _collegeFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _majorFieldKey =
      GlobalKey<FormFieldState<String>>();
  Map<String, List<String>> collegeMajorMap = {
    'King Abdullah II School of Information Technology': [
      'Computer Science',
      'Business Information Technology',
      'Computer Information Systems',
      'Artificial Intelligence',
      'Cyber Security'
    ],
    'School of Engineering': [
      'Civil Engineering',
      'Architecture Engineering',
      'Electrical Engineering',
      'Mechanical Engineering',
      'Chemical Engineering',
      'Industrial Engineering',
      'Computer Engineering',
      'Mechatronic\'s Engineering',
    ]
  };
  List<String> colleges = [];
  String? selectedCollege;
  String? selectedMajor;
  @override
  void initState() {
    super.initState();
    colleges = collegeMajorMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: DataCollectionWidget(
          pageBody: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
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
                  height: 100,
                ),
                SizedBox(
                  width: size.width * .9,
                  child: DropdownButtonFormField<String>(
                    key: _collegeFieldKey,
                    value: selectedCollege,
                    dropdownColor: Colors.white,
                    iconEnabledColor: AppColors.kDarkGreen,
                    menuMaxHeight: 300.0,
                    decoration: const InputDecoration(
                      labelText: 'College',
                      labelStyle: TextStyle(
                        color: AppColors.kDarkGreen,
                        fontWeight: FontWeight.w500,
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: AppColors.kDarkGreen)),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    items: collegeDropdownMenuEntries,
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
                    onChanged: (college) {
                      setState(() {
                        selectedCollege = college;
                        selectedMajor = null;
                      });
                      _collegeFieldKey.currentState?.validate();
                    },
                    validator: (college) {
                      if (college == null) {
                        return "Please select your college";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: size.width * .9,
                  child: DropdownButtonFormField<String>(
                    key: _majorFieldKey,
                    value: selectedMajor,
                    dropdownColor: Colors.white,
                    iconEnabledColor: AppColors.kDarkGreen,
                    menuMaxHeight: 300.0,
                    decoration: const InputDecoration(
                      labelText: 'Major',
                      labelStyle: TextStyle(
                        color: AppColors.kDarkGreen,
                        fontWeight: FontWeight.w500,
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    items: majorDropDownMenuEntries,
                    selectedItemBuilder: (BuildContext context) {
                      return majors.map((college) {
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
                    onChanged: (major) {
                      setState(() {
                        selectedMajor = major;
                      });
                      _majorFieldKey.currentState?.validate();
                    },
                    validator: (major) {
                      if (major == null) {
                        return 'Please select your major';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          dataCollectionPageIndex: 1,
          previousPage: NameCollectionPage(),
          nextPage: InterestCollection(),
          pageFormKey: _collegeMajorFormKey),
    );
  }
}
