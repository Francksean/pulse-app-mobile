part of 'appointment_creation_cubit.dart';

abstract class AppointmentCreationState extends Equatable {
  const AppointmentCreationState();

  @override
  List<Object?> get props => [];
}

class AppointmentCreationInitial extends AppointmentCreationState {
  final Appointment? savedAppointment;

  const AppointmentCreationInitial({this.savedAppointment});

  @override
  List<Object?> get props => [savedAppointment];
}

class AppointmentCreationLoading extends AppointmentCreationState {}

class AppointmentCreationSuccess extends AppointmentCreationState {
  final Appointment appointment;

  const AppointmentCreationSuccess(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AppointmentCreationError extends AppointmentCreationState {
  final String errorMessage;

  const AppointmentCreationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
