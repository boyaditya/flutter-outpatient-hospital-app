import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/profile/detail_profile.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';

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
        title: const Text('Profil Pasien',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
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
            BlocBuilder<PatientListCubit, List<PatientModel>>(
              builder: (context, patients) {
                if (patients.isEmpty) {
                  return const Text('No patients found');
                }
                final patient = patients[0];
                return PatientDetailButton(
                  patient: patient,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProfilPasien(),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Orang Lain',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            BlocBuilder<PatientListCubit, List<PatientModel>>(
              builder: (context, patients) {
                if (patients.length <= 1) {
                  return const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Anda belum menambahkan profil untuk orang lain',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: patients.length > 1 ? patients.length - 1 : 0,
                      itemBuilder: (context, index) {
                        final patient = patients[index + 1];

                        return PatientDetailButton(
                          patient: patient,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProfilPasien(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrationScreen(),
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
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          disabledForegroundColor: Colors.grey.withOpacity(0.38),
          disabledBackgroundColor: Colors.grey.withOpacity(0.12),
          backgroundColor: Colors.blue[50],
          padding: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Colors.grey, width: 0.3),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
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
    );
  }
}
