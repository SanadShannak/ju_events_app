import 'package:flutter/material.dart';

import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/validators.dart';
import 'package:temp_project/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import '../../providers/data_collection_provider.dart';

class NameCollectionPage extends StatelessWidget {
  NameCollectionPage({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? savedName =
        Provider.of<DataCollectionProvider>(context, listen: true).name;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 3,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'What should we call you?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kDarkGreen),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: size.width * .8,
              child: CustomTextFormField(
                hint: savedName != null &&
                        savedName.trim().isNotEmpty &&
                        savedName.isNotEmpty
                    ? savedName
                    : 'enter your name',
                  
                formType: FormType.userName,
                validator: Validators.username,
                controller: _nameController,
                onTextChange: (value) {
                  context.read<DataCollectionProvider>().updateName(value);
                },
                lettersAndSpacesOnly: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
