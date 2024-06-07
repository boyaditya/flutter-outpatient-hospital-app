import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/lihat_janji_temu/histori_janji_temu.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';

class JanjiTemuSaya2 extends StatefulWidget {
  const JanjiTemuSaya2({super.key});

  @override
  State<JanjiTemuSaya2> createState() => _JanjiTemuSaya2State();
}

class _JanjiTemuSaya2State extends State<JanjiTemuSaya2> {
  int _selectedTabIndex = 0; // Menyimpan indeks teks yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80), // Spasi untuk tombol
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(230, 30),
                          ),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Janji Temu Saya",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Janji temu yang akan datang",
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        _buildIsian(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const HistoriJanjiTemu(title: 'Histori Janji Temu'),
                  ),
                );
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "LIHAT HISTORI JANJI TEMU",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // Perbarui indeks yang dipilih
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: _selectedTabIndex == index
              ? Colors.white
              : const Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }

  Widget _buildIsian() {
    return BlocBuilder<AppointmentCubit, List<AppointmentModel>>(
      builder: (context, appointments) {
        if (appointments.isEmpty) {
          return Center(
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
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...appointments
                .where((appointment) => appointment.status == 'Scheduled')
                .map(
              (appointment) {
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
                return TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RincianJanjiTemu(
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
                    elevation: 4, // Add elevation for shadow effect
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: 13, color: Colors.black),
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
                            borderRadius: BorderRadius.circular(8),
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
                );
              },
            ),
          ],
        );
      },
    );
  }
}
