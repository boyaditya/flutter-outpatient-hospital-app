import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';

class PeriksaJanjiTemu extends StatefulWidget {
  final String selectedDate;
  final String scheduleTime;
  final int patientId;
  final int doctorId;
  final String specialization;

  const PeriksaJanjiTemu({
    super.key,
    required this.selectedDate,
    required this.scheduleTime,
    required this.patientId,
    required this.doctorId,
    required this.specialization,
  });

  @override
  State<PeriksaJanjiTemu> createState() => _PeriksaJanjiTemuState();
}

class _PeriksaJanjiTemuState extends State<PeriksaJanjiTemu> {
  static const List<String> listPenjamin = <String>[
    'BPJS',
    'Asuransi Swasta',
    'Pribadi'
  ];

  String penjaminValue = listPenjamin.first;

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientListCubit, List<PatientModel>>(
        builder: (context, state) {
      final patient =
          state.firstWhere((element) => element.id == widget.patientId);

      final doctor = context
          .read<DoctorListCubit>()
          .state
          .firstWhere((element) => element.id == widget.doctorId);

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Periksa Janji Temu',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Silahkan periksa kembali detail janji temu untuk memastikan kesesuaian informasi sebelum Anda melakukan konfirmasi",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI PASIEN",
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
                        value: DateFormat('dd MMMM yyyy', 'id')
                            .format(patient.dateOfBirth),
                      ),
                      InfoItem(
                        label: "NOMOR TELEPON",
                        value: patient.phone,
                      ),
                      InfoItem(
                        label: "JENIS KELAMIN",
                        value: patient.gender,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI JANJI TEMU",
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
                            "${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.parse(widget.selectedDate))}, ${widget.scheduleTime}",
                      ),
                      InfoItem(
                        label: "DOKTER",
                        value: doctor.name,
                      ),
                      InfoItem(
                        label: "SPESIALIS",
                        value: widget.specialization,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI PENJAMIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: penjaminValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        isExpanded:
                            true, // Make the dropdown expand to fit its content
                        items: listPenjamin.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            penjaminValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);

                    int newAppointmentId = await performCreateAppointment();
                    if (newAppointmentId != 0) {
                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) => RincianJanjiTemu(
                            appointmentId: newAppointmentId,
                            from: 'periksa_janji_temu',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      40,
                    ),
                  ),
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<int> performCreateAppointment() async {
    final appointment = AppointmentModel(
      id: 0,
      timestamp: '',
      doctorId: widget.doctorId,
      patientId: widget.patientId,
      date: widget.selectedDate,
      time: widget.scheduleTime,
      coverageType: penjaminValue,
      status: 'Scheduled',
      queueNumber: 0,
    );

    try {
      int id =
          await context.read<AppointmentCubit>().postAppointment(appointment);
      showSuccessMessage('Janji temu berhasil dibuat');
      return id;
    } catch (e) {
      showErrorMessage('Gagal membuat janji temu');
      return 0;
    }
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

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
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
