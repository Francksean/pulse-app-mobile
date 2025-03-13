import 'package:pulse_app_mobile/appointment/model/appointment.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';

class AppointmentService {
  final dioClient = DioClient.instance;

  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final appointmentData = appointment.toJson();

      final response = await dioClient.dio.post(
        "/appointments/new",
        data: appointmentData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Appointment.fromJson(response.data);
      } else {
        throw Exception(
            "Erreur lors de la création du rendez-vous: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(
          "Erreur lors de la création du rendez-vous: ${e.toString()}");
    }
  }
}
