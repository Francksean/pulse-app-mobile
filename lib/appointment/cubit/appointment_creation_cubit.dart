import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/appointment/model/appointment.dart';
import 'package:pulse_app_mobile/appointment/service/appointment_service.dart';
import 'package:pulse_app_mobile/common/database/secure_storage_service.dart';

part 'appointment_creation_state.dart';

class AppointmentCreationCubit extends Cubit<AppointmentCreationState> {
  final appointmentService = AppointmentService();

  AppointmentCreationCubit() : super(const AppointmentCreationInitial());

  Future<void> createAppointment(Appointment appointment) async {
    emit(AppointmentCreationLoading());

    try {
      final secureStorage = SecureStorageService();
      final donorId = await secureStorage.getUserId();
      appointment.donorId = donorId;
      final createdAppointment =
          await appointmentService.createAppointment(appointment);

      emit(AppointmentCreationSuccess(createdAppointment));
    } catch (e) {
      emit(AppointmentCreationError(
          "Erreur lors de la création du rendez-vous: ${e.toString()}"));
    }
  }

  // New method to save form state when navigating away
  void saveFormState(Appointment appointment) {
    emit(AppointmentCreationInitial(savedAppointment: appointment));
  }
}
