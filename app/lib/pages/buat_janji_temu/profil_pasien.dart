import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
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
  PatientModel? selectedPatient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Pasien',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 10, 0, 10),
                        child: Text(
                          'SAYA SENDIRI',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      PatientDetailButton(
                        patient: patients[0],
                        onChanged: (value) {
                          setState(() {
                            selectedPatient = patients[0];
                          });
                        },
                        groupValue: selectedPatient == patients[0],
                        appointmentCubit:
                            BlocProvider.of<AppointmentCubit>(context),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 10, 0, 10),
                        child: Text(
                          'Orang Lain',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
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
                            return PatientDetailButton(
                              patient: patient,
                              onChanged: (value) {
                                setState(() {
                                  selectedPatient = patient;
                                });
                              },
                              groupValue: selectedPatient == patient,
                              appointmentCubit:
                                  BlocProvider.of<AppointmentCubit>(context),
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
          onPressed: selectedPatient != null
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeriksaJanjiTemu(
                          selectedDate: widget.selectedDate,
                          scheduleTime: widget.scheduleTime,
                          patientId: selectedPatient!.id,
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

class PatientDetailButton extends StatelessWidget {
  final PatientModel patient;
  final ValueChanged<bool?> onChanged;
  final bool groupValue;
  final AppointmentCubit appointmentCubit;

  const PatientDetailButton({
    super.key,
    required this.patient,
    required this.onChanged,
    required this.groupValue,
    required this.appointmentCubit,
  });

  @override
  Widget build(BuildContext context) {
    bool hasActiveAppointment =
        appointmentCubit.patientHasActiveAppointment(patient.id);
    return Column(
      children: [
        RadioListTile<bool>(
          value: true,
          groupValue: groupValue,
          onChanged: hasActiveAppointment
              ? null
              : onChanged, // Disable the radio button if the patient has an active appointment
          activeColor: Colors.blue,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: hasActiveAppointment
                  ? Colors.red[100]
                  : (groupValue
                      ? Colors.blue[200]
                      : Colors.blue[
                          50]), // Change the color to red if the patient has an active appointment
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4, // Add blur effect
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasActiveAppointment) // Only display this text if the patient has an active appointment
                  const Text(
                    "Pasien memiliki janji temu yang aktif",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                  ),
                Text(
                  patient.name,
                  style: TextStyle(
                    color: hasActiveAppointment
                        ? Colors.red
                        : Colors
                            .black, // Change the color to red if the patient has an active appointment
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  DateFormat('dd MMM yyyy').format(patient.dateOfBirth),
                  style: TextStyle(
                    color: hasActiveAppointment ? Colors.red : Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  patient.gender,
                  style: TextStyle(
                    color: hasActiveAppointment ? Colors.red : Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 2.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}
