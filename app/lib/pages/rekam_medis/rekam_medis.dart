import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/medical_record_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/rekam_medis/detail_rm.dart';

class RekamMedis extends StatefulWidget {
  const RekamMedis({super.key});

  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, List<MedicalRecordModel>>(
      builder: (context, medicalRecords) {
        if (medicalRecords.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Rekam Medis'),
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
                  'Tidak ada rekam medis',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Rekam Medis'),
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
                    children: medicalRecords.map((record) {
                      final appointment = context
                          .read<AppointmentCubit>()
                          .getAppointmentById(record.appointmentId);
                      final patient = context
                          .read<PatientListCubit>()
                          .getPatientById(appointment.patientId);
                      final doctor = context
                          .read<DoctorListCubit>()
                          .getDoctorById(appointment.doctorId);
                      final specialization = context
                          .read<SpecializationListCubit>()
                          .getSpecializationById(doctor.idSpecialization);
                      final specializationTitle = specialization.title;
                      return Card(
                        color: Colors.blue[0],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profil Pasien: ${patient.name}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 3.0,
                                    height: 63.0,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(specializationTitle),
                                      Text(
                                        "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRekamMedis(
                                            medicalRecordId: record.id,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[700],
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                    child: const Text(
                                      'Lihat Detail',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
