import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/medical_record_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/dashboard/dashboard.dart';

class RincianJanjiTemu extends StatefulWidget {
  const RincianJanjiTemu(
      {super.key, required this.from, required this.appointmentId});

  final String from;
  final int appointmentId;

  @override
  State<RincianJanjiTemu> createState() => _RincianJanjiTemuState();
}

class _RincianJanjiTemuState extends State<RincianJanjiTemu> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content:
              const Text('Apakah Anda yakin ingin membatalkan janji temu?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                await context
                    .read<AppointmentCubit>()
                    .setStatusCancelled(widget.appointmentId);
                if (context.mounted) {
                  Navigator.of(context).pop(); // Tutup dialog konfirmasi
                  _showCancellationSuccessDialog(context);
                }
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _showCancellationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pembatalan Berhasil'),
          content: const Text('Janji temu berhasil dibatalkan.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(initialIndex: 1),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckInDialog(
      BuildContext context, MedicalRecordModel appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Check-In'),
          content: const Text(
              'Apakah Anda yakin ingin melakukan check-in? Anda tidak dapat membatalkan check-in setelah ini.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<AppointmentCubit>().setStatusComplete(widget
                    .appointmentId); // Change this to the function that checks in the patient

                if (context.mounted) {
                  await context.read<MedicalRecordCubit>().postMedicalRecord(
                      appointment); // Change this to the function that checks in the patient
                }

                if (context.mounted) {
                  Navigator.of(context).pop(); // Close confirmation dialog
                  _showCheckInSuccessDialog(
                      context); // Show a success dialog after check-in
                }
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckInSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check-In Berhasil'),
          content: const Text('Anda telah berhasil melakukan check-in.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(initialIndex: 1),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  late int idSpecialization;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rincian Janji Temu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        automaticallyImplyLeading: widget.from != 'periksa_janji_temu',
        actions: [
          IconButton(
            onPressed: () {
              // Logika ketika tombol butuh bantuan diklik
            },
            icon: const Icon(Icons.help),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Butuh\nBantuan?',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<AppointmentCubit, List<AppointmentModel>>(
                builder: (context, state) {
              final appointment = state.firstWhere(
                  (appointment) => appointment.id == widget.appointmentId);
              final patient = context
                  .read<PatientListCubit>()
                  .getPatientById(appointment.patientId);
              final doctor = context
                  .read<DoctorListCubit>()
                  .getDoctorById(appointment.doctorId);
              final specialization = context
                  .read<SpecializationListCubit>()
                  .getSpecializationById(doctor.idSpecialization);
              idSpecialization = doctor.idSpecialization;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Barcode
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(-2, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        '../../../assets/images/barcode.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nomor Antrian',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appointment.queueNumber.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pindai kode QR di Kios untuk Check In',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Teks INFO STATUS
                      const Text(
                        "INFO STATUS",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Container untuk info status
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 245, 225, 10),
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Silahkan menuju ke QR Code scanner",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Menunggu verifikasi pasien",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "INFO PASIEN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InfoItem(
                              label: "NAMA LENGKAP",
                              value: patient.name,
                            ),
                            InfoItem(
                              label: "NOMOR INDUK KEPENDUDUKAN",
                              value: patient.nik,
                            ),
                            InfoItem(
                              label: "TANGGAL LAHIR",
                              value: DateFormat('dd MMMM yyyy', 'id').format(
                                DateTime.parse(
                                  patient.dateOfBirth.toString(),
                                ),
                              ),
                            ),
                            InfoItem(
                              label: "JENIS KELAMIN",
                              value: patient.gender,
                            ),
                            InfoItem(
                              label: "NOMOR PONSEL",
                              value: patient.phone,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "INFO JANJI TEMU",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InfoItem(
                              label: "TANGGAL DAN WAKTU JANJI TEMU",
                              value:
                                  "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(appointment.date))}, ${appointment.time} WIB",
                            ),
                            InfoItem(
                              label: "DOKTER",
                              value: doctor.name,
                            ),
                            InfoItem(
                              label: "SPESIALIS",
                              value: specialization.title,
                            ),
                          ],
                        ),
                      ),
											const SizedBox(height: 20),
                    const Text(
                      "INFORMASI PENJAMIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
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
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Private",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                      const SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          List<MedicalRecordModel> medicalRecords = [
                            if (specialization.title == 'Akupuntur')
                              MedicalRecordModel(
                                id: 0,
                                appointmentId: appointment.id,
                                complaint: 'Sakit kepala',
                                diagnosis: 'Migrain',
                                treatment: 'Terapi akupuntur',
                                notes: 'Lakukan terapi secara rutin',
                              ),
                            if (specialization.title == 'Dermatologi')
                              MedicalRecordModel(
                                id: 0,
                                appointmentId: appointment.id,
                                complaint: 'Kulit gatal dan merah',
                                diagnosis: 'Eksim',
                                treatment: 'Krim topikal',
                                notes: 'Hindari kontak dengan alergen',
                              ),
                            if (specialization.title == 'Penyakit Dalam')
                              MedicalRecordModel(
                                id: 0,
                                appointmentId: appointment.id,
                                complaint: 'Sesak napas',
                                diagnosis: 'Asma',
                                treatment: 'Inhaler',
                                notes: 'Hindari asap dan debu',
                              ),
                            if (specialization.title == 'Kedokteran Gigi')
                              MedicalRecordModel(
                                id: 0,
                                appointmentId: appointment.id,
                                complaint: 'Gigi berlubang',
                                diagnosis: 'Karies',
                                treatment: 'Tambal gigi',
                                notes: 'Perbanyak konsumsi air putih',
                              ),
                          ];

                          _showCheckInDialog(
                              context, medicalRecords[0]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        child: const Text('Check In Sekarang',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        child: const Text('Batalkan Janji Temu',
                            style: TextStyle(color: Colors.white)),
                      ),

                      const SizedBox(height: 20),
                      if (widget.from == 'periksa_janji_temu')
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Dashboard(initialIndex: 1),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 80, 130, 215),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          child: const Text('Lihat Halaman Janji Temu',
                              style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
