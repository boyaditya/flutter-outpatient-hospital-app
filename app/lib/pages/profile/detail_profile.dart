import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/profile/edit_profile.dart';

class DetailProfilPasien extends StatefulWidget {
  const DetailProfilPasien({super.key, required this.patientId});

  final int patientId;

  @override
  State<DetailProfilPasien> createState() => _DetailProfilPasienState();
}

class _DetailProfilPasienState extends State<DetailProfilPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Profil Pasien',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<PatientListCubit, List<PatientModel>>(
        builder: (context, patients) {
          if (patients.isEmpty) {
            return const Text('No patients found');
          }
          final patient =
              patients.firstWhere((patient) => patient.id == widget.patientId);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),
              InfoCard(
                icon: Icons.person,
                title: 'Profil Pasien',
                content: [
                  {'label': 'Nama Lengkap', 'value': patient.name},
                  {'label': 'NIK', 'value': patient.nik},
                  {'label': 'Jenis Kelamin', 'value': patient.gender},
                  {
                    'label': 'Tanggal Lahir',
                    'value':
                        DateFormat('dd MMM yyyy').format(patient.dateOfBirth)
                  },
                  {'label': 'No Telepon', 'value': patient.phone},
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 25),
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Permintaan Perubahan Data',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Map<String, String>> content;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[50],
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            offset: Offset(-2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...content.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['label']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      item['value']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
