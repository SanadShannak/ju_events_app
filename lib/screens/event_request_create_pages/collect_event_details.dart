import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import '../../widgets/custom_text_form_field.dart';
import 'event_provider.dart';

extension TimeOfDayExtension on TimeOfDay {
  String to12HourFormat() {
    final hour = hourOfPeriod.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _subLocationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<EventProvider>().key = _formKey;
    super.initState();
  }

  Widget getLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.kDarkGreen, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDateTime = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDateTime,
        firstDate: currentDateTime,
        lastDate: currentDateTime.copyWith(year: currentDateTime.year + 5),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: AppColors.kForestGreen // circle color
                  ),
            ),
            child: child!,
          );
        });

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.kForestGreen, // dial background color
            ),
            timePickerTheme: TimePickerThemeData(
              dayPeriodTextColor: AppColors.kForestGreen, // AM/PM text color
              dayPeriodColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? AppColors.kForestGreen.withAlpha(50) // Selected AM/PM background
                    : Colors.transparent, // Unselected AM/PM background
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _startingTimeController.text = pickedTime.to12HourFormat();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<EventProvider>(
      builder: (BuildContext context, EventProvider event, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Added for better alignment
                children: [
                  getLabel('Title'),
                  CustomTextFormField(
                    formType: FormType.normalUse,
                    hint: 'Enter Event Title',
                    controller: _titleController,
                    validator: (value) {
                      try {
                        event.name = value;
                      } on ArgumentError catch (e) {
                        return e.message;
                      }
                      return null;
                    },
                  ),
                  getLabel('Location'),
                  CustomTextFormField(
                    formType: FormType.normalUse,
                    hint: 'Enter Event Location',
                    controller: _locationController,
                    validator: (value) {
                      try {
                        event.locationInfo = value;
                      } on ArgumentError catch (e) {
                        return e.message;
                      }
                      return null;
                    },
                  ),
                  getLabel('Sub Location'),
                  CustomTextFormField(
                    formType: FormType.normalUse,
                    hint: 'Enter Event Sub Location',
                    controller: _subLocationController,
                    validator: (value) {
                      event.subLocationInfo = value;
                      return null;
                    },
                  ),
                  getLabel('Date'),
                  CustomTextFormFieldContainer(
                    textFormField: TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        hintText: 'Pick Event Date',
                        contentPadding: EdgeInsets.only(left: 20),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.kDarkGreen,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await _selectDate(context);
                      },
                      validator: (value) {
                        try {
                          if (value == null || value.isEmpty) {
                            return "Date Field Can't be empty.";
                          }

                          List<String> dateParts = value.split('-');
                          event.date =
                              DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]), int.parse(dateParts[2]));
                        } on ArgumentError catch (e) {
                          return e.message;
                        }
                        return null;
                      },
                    ),
                    screenWidthRatio: 0.9,
                  ),
                  getLabel('Starting Time'),
                  CustomTextFormFieldContainer(
                    textFormField: TextFormField(
                      validator: (value) {
                        try {
                          if (value == null || value.isEmpty) {
                            return "Starting Time Field Can't be empty.";
                          }
                          final timeComponents = value.split(' ');
                          final timeWithoutPeriod = timeComponents[0].split(':');
                          final period = timeComponents[1].toUpperCase();

                          int hour = int.parse(timeWithoutPeriod[0]);
                          final minute = int.parse(timeWithoutPeriod[1]);

                          // Adjust hour based on AM/PM
                          if (period == 'PM' && hour != 12) {
                            hour += 12;
                          } else if (period == 'AM' && hour == 12) {
                            hour = 0;
                          }
                          event.startingTime = TimeOfDay(hour: hour, minute: minute);
                        } on ArgumentError catch (e) {
                          return e.message;
                        }
                        return null;
                      },
                      controller: _startingTimeController,
                      decoration: const InputDecoration(
                        hintText: 'Pick Starting Event Time',
                        contentPadding: EdgeInsets.only(left: 20),
                        suffixIcon: Icon(
                          Icons.access_time,
                          color: AppColors.kDarkGreen,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await _selectTime(context);
                      },
                    ),
                    screenWidthRatio: 0.9,
                  ),
                  getLabel('Description'),
                  Container(
                    width: size.width * 0.9,
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      validator: (value) {
                        event.description = value;
                        return null;
                      },
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Event Description ...',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
