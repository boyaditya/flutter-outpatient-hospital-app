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
    PatientModel? selectedPatient;
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
                      // PatientDetailButton(
                      //   patient: patients[0],
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => DetailProfilPasien(
                      //           patientId: patients[0].id,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
               PatientDetailButton(
                        patient: patients[0],
                        onChanged: (value) {
                          setState(() {
                            selectedPatient = patients[0];
                          });
                        },
                        groupValue: selectedPatient == patients[0],
                      ),
                      const Text(
                        'Orang Lain',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      if (patients.length == 1)
                        const Column(
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
                        )
                      else
                        ...patients.skip(1).map(
                          (patient) {
                            // return PatientDetailButton(
                            //   patient: patient,
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => DetailProfilPasien(
                            //           patientId: patient.id,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                            return PatientDetailButton(
                              patient: patient,
                              onChanged: (value) {
                                setState(() {
                                  selectedPatient = patient;
                                });
                              },
                              groupValue: selectedPatient == patient,
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
  final ValueChanged<bool?> onChanged;
  final bool groupValue;

  const PatientDetailButton({
    Key? key,
    required this.patient,
    required this.onChanged,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<bool>(
          value: true,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.blue,
          title: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4, // Add blur effect
                ),
              ],
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
        const SizedBox(height: 10.0),
      ],
    );
  }
}