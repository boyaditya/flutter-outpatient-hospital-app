import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/buat_janji_temu/periksa_janji_temu.dart';

class ProfilPasien extends StatefulWidget {
  const ProfilPasien(
      {super.key,
      required this.selectedDate,
      required this.scheduleTime,
      required this.doctorId,
      required this.specialization});

  final String selectedDate;
  final String scheduleTime;
  final int doctorId;
  final String specialization;

  @override
  State<ProfilPasien> createState() => _ProfilPasienState();
}

class _ProfilPasienState extends State<ProfilPasien> {
  int? patientId;

  void updatePatientId(int newPatientId) {
    setState(() {
      patientId = newPatientId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Pasien',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          const Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SAYA SENDIRI",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                BlocBuilder<PatientListCubit, List<PatientModel>>(
                  builder: (context, patients) {
                    if (patients.isEmpty) {
                      return const CircularProgressIndicator(); // Show a loading spinner if patients is null or empty
                    } else {
                      final patient = patients[0];
                      return PatientContainer(
                        id: patient.id,
                        nama: patient.name,
                        nik: patient.nik,
                        dateOfBirth: DateFormat('dd MMMM yyyy', 'id')
                            .format(patient.dateOfBirth),
                        gender: patient.gender,
                        noHP: patient.phone,
                        onPatientDataChanged: updatePatientId,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "ORANG LAIN",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 90),
                const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.groups,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Anda belum menambahkan profil untuk orang lain",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: patientId != null
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeriksaJanjiTemu(
                          selectedDate: widget.selectedDate,
                          scheduleTime: widget.scheduleTime,
                          patientId: patientId!,
                          doctorId: widget.doctorId,
                          specialization: widget.specialization),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Selanjutnya',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PatientContainer extends StatefulWidget {
  final int id;
  final String nama;
  final String nik;
  final String dateOfBirth;
  final String gender;
  final String noHP;
  final ValueChanged<int> onPatientDataChanged;

  const PatientContainer({
    super.key,
    required this.id,
    required this.nama,
    required this.nik,
    required this.dateOfBirth,
    required this.gender,
    required this.noHP,
    required this.onPatientDataChanged,
  });

  @override
  State<PatientContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<PatientContainer> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isToggled = !_isToggled;
        });

        if (_isToggled) {
          widget.onPatientDataChanged(widget.id);
        } else {
          widget.onPatientDataChanged(0);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isToggled ? Colors.blue : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(-2, 2),
            ),
          ],
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nomor Induk Kependudukan ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Tanggal Lahir ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'No. Telepon ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Jenis Kelamin ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.nama,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.nik,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.dateOfBirth,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.noHP,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.gender,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
