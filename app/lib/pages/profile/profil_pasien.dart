import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/profile/detail_profile.dart';
import 'package:tubes/pages/profile/tambah_profil.dart';

class ProfilPasienScreen extends StatefulWidget {
  const ProfilPasienScreen({super.key});

  @override
  State<ProfilPasienScreen> createState() => _ProfilPasienScreenState();
}

class _ProfilPasienScreenState extends State<ProfilPasienScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Pasien',
        ),
      ),
      body: BlocBuilder<PatientListCubit, List<PatientModel>>(
        builder: (context, patients) {
          if (patients.isEmpty) {
            return const Text('No patients found');
          } else {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SAYA SENDIRI',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      PatientDetailButton(
                        patient: patients[0],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailProfilPasien(
                                patientId: patients[0].id,
                              ),
                            ),
                          );
                        },
                      ),
                      const Text(
                        'Orang Lain',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      if (patients.length == 1)
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 100.0),
                              Icon(
                                Icons.people,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Text(
                                'Anda belum menambahkan profil untuk orang lain',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      else
                        ...patients.skip(1).map(
                          (patient) {
                            return PatientDetailButton(
                              patient: patient,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProfilPasien(
                                      patientId: patient.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahProfilPasien(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Tambah Profil Lain',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PatientDetailButton extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback onPressed;

  const PatientDetailButton({
    super.key,
    required this.patient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton(
            onPressed: onPressed,
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
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    DateFormat('dd MMM yyyy').format(patient.dateOfBirth),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    patient.gender,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
