import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pulse_app_mobile/appointment/cubit/appointment_creation_cubit.dart';
import 'package:pulse_app_mobile/appointment/enums/appointment_type.dart';
import 'package:pulse_app_mobile/appointment/model/appointment.dart';
import 'package:pulse_app_mobile/common/components/custom_input_field.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

// Enum for appointment types

class CreateAppointmentScreen extends StatefulWidget {
  String centerId;
  CreateAppointmentScreen({super.key, required this.centerId});

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _focusedDate = DateTime.now();
  AppointmentType? _selectedType = AppointmentType.advice;

  // Map to store descriptions for each appointment type
  final Map<AppointmentType, String> _typeDescriptions = {
    AppointmentType.advice:
        "Une session de advice personnalisés avec un professionnel de santé pour discuter et poser vos questions.",
    AppointmentType.levy:
        "Un rendez-vous pour effectuer des prélèvements sanguins ou autres analyses médicales nécessaires.",
    AppointmentType.donation:
        "Un rendez-vous pour faire un don de sang, de plasma ou d'autres composants sanguins pour aider ceux qui en ont besoin.",
  };

  @override
  void initState() {
    super.initState();
    // Listen to the cubit state to pre-fill form if needed
    final cubitState = context.read<AppointmentCreationCubit>().state;
    if (cubitState is AppointmentCreationInitial &&
        cubitState.savedAppointment != null) {
      final savedAppointment = cubitState.savedAppointment!;
      _descriptionController.text = savedAppointment.description!;
      _selectedDate = savedAppointment.appointmentDate;

      // Map the type string to enum
      if (savedAppointment.type == "advice") {
        _selectedType = AppointmentType.advice;
      } else if (savedAppointment.type == "levy") {
        _selectedType = AppointmentType.levy;
      } else if (savedAppointment.type == "don") {
        _selectedType = AppointmentType.donation;
      }
    }
  }

  @override
  void dispose() {
    // Save the current form state to the cubit when leaving
    if (_descriptionController.text.isNotEmpty ||
        _selectedDate != null ||
        _selectedType != null) {
      final appointment = Appointment(
        appointmentDate: _selectedDate ?? DateTime.now(),
        description: _descriptionController.text,
        type: _selectedType != null
            ? _selectedType.toString().split('.').last
            : "",
      );
      context.read<AppointmentCreationCubit>().saveFormState(appointment);
    }
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(DateTime picked) async {
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validate form
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Veuillez sélectionner une date")),
        );
        return;
      }

      if (_selectedType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Veuillez sélectionner un type de rendez-vous")),
        );
        return;
      }

      // Create Appointment object
      final appointment = Appointment(
        appointmentDate: _selectedDate!,
        description: _descriptionController.text,
        type: _selectedType.toString().split('.').last,
      );

      context.read<AppointmentCreationCubit>().createAppointment(appointment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Programmez un rendez-vous"),
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AppointmentCreationCubit, AppointmentCreationState>(
        listener: (context, state) {
          if (state is AppointmentCreationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Rendez-vous créé avec succès!"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is AppointmentCreationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDate!,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: CalendarStyle(
                              cellMargin: const EdgeInsets.all(4),
                              selectedDecoration: const BoxDecoration(
                                  color: AppColors.orange,
                                  shape: BoxShape.circle),
                              todayDecoration: BoxDecoration(
                                  color: AppColors.orange.withOpacity(0.5),
                                  shape: BoxShape.circle),
                            ),
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDate, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              final currentDateTime = DateTime.now();
                              Navigator.of(context).push(showPicker(
                                  // minHour: 9,
                                  // maxHour: 17,
                                  blurredBackground: true,
                                  accentColor: AppColors.red.withOpacity(0.5),
                                  value: Time(
                                      hour: currentDateTime.hour,
                                      minute: currentDateTime.minute,
                                      second: currentDateTime.second),
                                  onChange: (pickedTime) {
                                    print(pickedTime);
                                    final DateTime combinedDateTime = DateTime(
                                      selectedDay.year,
                                      selectedDay.month,
                                      selectedDay.day,
                                      pickedTime.hour,
                                      pickedTime.minute,
                                    );
                                    setState(() {
                                      _selectedDate = focusedDay;
                                      _selectDate(combinedDateTime);
                                      _focusedDate = focusedDay;
                                    });
                                  }));
                            },
                          ),

                          const SizedBox(height: 15),

                          // Description field
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black),
                          ),

                          const SizedBox(height: 8),
                          CustomInputField(
                            hintText: "Entrez la description du rendez-vous",
                            controller: _descriptionController,
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description requise";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Appointment type selection
                          const Text(
                            "Type de rendez-vous",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  _buildTypeOption(
                                      AppointmentType.advice,
                                      Icons.chat_bubble_outline,
                                      Colors.green[300]!),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    endIndent: 30,
                                    indent: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildTypeOption(
                                      AppointmentType.levy,
                                      Icons.science_outlined,
                                      Colors.blue[300]!),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    endIndent: 30,
                                    indent: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildTypeOption(AppointmentType.donation,
                                      Icons.volunteer_activism, AppColors.red),
                                ],
                              ),
                            ),
                          ),

                          // Type description
                          if (_selectedType != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    _selectedType == AppointmentType.advice
                                        ? Icons.info_outline
                                        : _selectedType == AppointmentType.levy
                                            ? Icons.science_outlined
                                            : Icons.volunteer_activism,
                                    color: AppColors.orange,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _typeDescriptions[_selectedType]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.white,
                    Color.fromARGB(193, 255, 255, 255),
                    Color.fromARGB(0, 255, 255, 255)
                  ],
                )),
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<AppointmentCreationCubit,
                    AppointmentCreationState>(
                  builder: (context, state) {
                    final isLoading = state is AppointmentCreationLoading;
                    return ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_alarm),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Créer le rendez-vous",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeOption(
      AppointmentType type, IconData icon, Color selectedColor) {
    final isSelected = _selectedType == type;
    final String typeLabel = type == AppointmentType.advice
        ? "Conseils"
        : type == AppointmentType.levy
            ? "Prélèvement"
            : "Don";

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? selectedColor : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                typeLabel,
                style: TextStyle(
                  color: isSelected ? selectedColor : AppColors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
