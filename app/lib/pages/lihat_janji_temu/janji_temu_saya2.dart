import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';

class JanjiTemuSaya2 extends StatefulWidget {
  const JanjiTemuSaya2({super.key});

  @override
  State<JanjiTemuSaya2> createState() => _JanjiTemuSaya2State();
}

class _JanjiTemuSaya2State extends State<JanjiTemuSaya2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, List<AppointmentModel>>(
      builder: (context, appointments) {
        // Filter the appointments to only include those with the status "Scheduled"
        List<AppointmentModel> scheduledAppointments = appointments
            .where((appointment) => appointment.status == 'Scheduled')
            .toList();
        if (scheduledAppointments.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Janji Temu Saya'),
            ),
            body: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Tidak ada janji temu yang akan datang',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          // Continue with your code to display the scheduledAppointments
          return Scaffold(
            appBar: AppBar(
              title: const Text('Janji Temu Saya'),
            ),
            body: ListView(
              children: [
                Container(
                  height: 1, // Garis batas
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...scheduledAppointments.map(
                            (appointment) {
                              final patient = context
                                  .read<PatientListCubit>()
                                  .getPatientById(appointment.patientId);
                              final doctor = context
                                  .read<DoctorListCubit>()
                                  .getDoctorById(appointment.doctorId);
                              final specialization = context
                                  .read<SpecializationListCubit>()
                                  .getSpecializationById(
                                      doctor.idSpecialization);
                              final specializationTitle = specialization.title;
                              return Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RincianJanjiTemu(
                                            appointmentId: appointment.id,
                                            from: 'dashboard',
                                          ),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.blue[50],
                                      shadowColor: Colors.grey,
                                      elevation:
                                          4, // Add elevation for shadow effect
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.person_4_outlined,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Rawat Jalan',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${patient.name}\n${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB\n${doctor.name}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            specializationTitle,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            width: 300,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Silahkan menuju ke QR Code scanner',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
