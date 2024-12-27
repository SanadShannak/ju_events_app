import 'package:flutter/material.dart';
import 'package:temp_project/screens/dataCollection/components/data_collection_widget.dart';
import 'package:temp_project/screens/dataCollection/components/drop_down_menu_widget.dart';
import 'package:temp_project/screens/dataCollection/interests_collection.dart';
import 'package:temp_project/screens/dataCollection/name_collection.dart';
import 'package:temp_project/utilities/constants.dart';

class CollegeMajorCollection extends StatefulWidget {
  const CollegeMajorCollection({super.key});

  @override
  State<CollegeMajorCollection> createState() => _CollegeMajorCollectionState();
}

class _CollegeMajorCollectionState extends State<CollegeMajorCollection> {
  final GlobalKey<FormState> _collegeMajorFormKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _collegeFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _majorFieldKey = GlobalKey<FormFieldState<String>>();
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
    List<String> majors = selectedCollege != null ? collegeMajorMap[selectedCollege!]! : [];
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
                  height: 170,
                ),
                const Text(
                  'Please Select your College and Major',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.kDarkGreen),
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
          dataCollectionPageIndex: 1,
          previousPage: NameCollectionPage(),
          nextPage: const InterestCollection(),
          pageFormKey: _collegeMajorFormKey),
    );
  }
}
