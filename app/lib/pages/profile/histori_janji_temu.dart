import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/medical_record_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';
import 'package:tubes/pages/rekam_medis/detail_rm.dart';

class HistoriJanjiTemu extends StatefulWidget {
  const HistoriJanjiTemu({super.key});

  @override
  State<HistoriJanjiTemu> createState() => _HistoriJanjiTemuState();
}

class _HistoriJanjiTemuState extends State<HistoriJanjiTemu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, List<AppointmentModel>>(
      builder: (context, appointments) {
        List<AppointmentModel> completeAppointments = appointments
            .where((appointment) => appointment.status == 'complete')
            .toList();
        List<AppointmentModel> cancelledAppointments = appointments
            .where((appointment) => appointment.status == 'cancelled')
            .toList();

        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Riwayat Janji Temu'),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Selesai",
                  ),
                  Tab(
                    text: "Dibatalkan",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ListView(
                  children: completeAppointments.isNotEmpty
                      ? completeAppointments.map((appointment) {
                          final patient = context
                              .read<PatientListCubit>()
                              .getPatientById(appointment.patientId);
                          final doctor = context
                              .read<DoctorListCubit>()
                              .getDoctorById(appointment.doctorId);
                          final specialization = context
                              .read<SpecializationListCubit>()
                              .getSpecializationById(doctor.idSpecialization);
                          final record = context
                              .read<MedicalRecordCubit>()
                              .getMedicalRecordByAppointmentId(appointment.id);
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                            child: _buildAppointmentCard(
                              context,
                              patient.name,
                              "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB",
                              doctor.name,
                              specialization.title,
                              true,
                              appointment.id,
                              record.id,
                            ),
                          );
                        }).toList()
                      : [
                          Expanded(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons
                                          .block, // Ikon yang menunjukkan tidak ada data
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Jarak antara ikon dan teks
                                    Text(
                                      'Tidak ada janji temu yang akan datang',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors
                                            .grey, // Ubah warna teks menjadi abu-abu
                                      ),
                                      textAlign: TextAlign
                                          .center, // Agar teks berada di tengah
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
                ListView(
                  children: cancelledAppointments.isNotEmpty
                      ? cancelledAppointments.map((appointment) {
                          final patient = context
                              .read<PatientListCubit>()
                              .getPatientById(appointment.patientId);
                          final doctor = context
                              .read<DoctorListCubit>()
                              .getDoctorById(appointment.doctorId);
                          final specialization = context
                              .read<SpecializationListCubit>()
                              .getSpecializationById(doctor.idSpecialization);
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                            child: _buildAppointmentCard(
                              context,
                              patient.name,
                              "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB",
                              doctor.name,
                              specialization.title,
                              false,
                              appointment.id,
                              0,
                            ),
                          );
                        }).toList()
                      : [
                          Expanded(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons
                                          .block, // Ikon yang menunjukkan tidak ada data
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Jarak antara ikon dan teks
                                    Text(
                                      'Tidak ada janji temu yang akan datang',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors
                                            .grey, // Ubah warna teks menjadi abu-abu
                                      ),
                                      textAlign: TextAlign
                                          .center, // Agar teks berada di tengah
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildAppointmentCard(
    BuildContext context,
    String patient,
    String date,
    String doctor,
    String specialization,
    bool showButton,
    int appointmentId,
    int recordId) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Colors.blue[50],
    elevation: 4,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$patient\n$date\n$doctor",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            specialization,
            style: const TextStyle(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RincianJanjiTemu(
                          appointmentId: appointmentId,
                          from: 'histori',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Detail Janji Temu",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (showButton)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRekamMedis(
                            medicalRecordId: recordId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Rekam Medis",
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
