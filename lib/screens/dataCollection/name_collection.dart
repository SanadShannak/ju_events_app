import 'package:flutter/material.dart';
import 'package:temp_project/screens/dataCollection/college_major_collection.dart';
import 'package:temp_project/screens/dataCollection/components/data_collection_widget.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/validators.dart';
import 'package:temp_project/widgets/custom_text_form_field.dart';

class NameCollectionPage extends StatelessWidget {
  NameCollectionPage({super.key});
  final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DataCollectionWidget(
        pageBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 3,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'What should we call you?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.kDarkGreen),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * .8,
              child: CustomTextFormField(
                hint: 'enter your name',
                formType: FormType.userName,
                validator: Validators.username,
                controller: _usernameController,
              ),
            )
          ],
        ),
        pageFormKey: _usernameFormKey,
        dataCollectionPageIndex: 0,
        nextPage: const CollegeMajorCollection(),
      ),
    );
  }
}
