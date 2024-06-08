import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/medical_record_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';

class DetailRekamMedis extends StatefulWidget {
  const DetailRekamMedis({super.key, required this.medicalRecordId});

  final int medicalRecordId;

  @override
  State<DetailRekamMedis> createState() => _DetailRekamMedisState();
}

class _DetailRekamMedisState extends State<DetailRekamMedis> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, List<MedicalRecordModel>>(
      builder: (context, state) {
        final record = context
            .read<MedicalRecordCubit>()
            .getMedicalRecordById(widget.medicalRecordId);
        final appointment = context
            .read<AppointmentCubit>()
            .getAppointmentById(record.appointmentId);
        final patient = context
            .read<PatientListCubit>()
            .getPatientById(appointment.patientId);
        final doctor =
            context.read<DoctorListCubit>().getDoctorById(appointment.doctorId);
        final specialization = context
            .read<SpecializationListCubit>()
            .getSpecializationById(doctor.idSpecialization);
        final specializationTitle = specialization.title;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Rekam Medis'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Doctor profile picture
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the radius as needed
                            child: Image.network(
                              doctor.imgPath,
                              height: 100, // Adjust the size as needed
                              width: 100, // Adjust the size as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 3.0,
                                    height: 50.0,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB",
                                      ),
                                      Text(specializationTitle)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Keluhan',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      record.complaint,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Diagnosa',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      record.diagnosis,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Terapi Obat',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      record.treatment,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Catatan Dokter',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      record.notes,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
