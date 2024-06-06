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
  static const List<String> listSpesialisasi = <String>[
    'One',
    'Two',
    'Three',
    'Four'
  ];

  String spesialisasiValue = listSpesialisasi.first;

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
    // print(widget.patientId);
    final patientListCubit = BlocProvider.of<PatientListCubit>(context);
    final patient = patientListCubit.getPatientById(widget.patientId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Periksa Janji Temu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          Padding(
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
                      BlocBuilder<DoctorListCubit, List<DoctorModel>>(
                        builder: (context, state) {
                          try {
                            DoctorModel doctor = context
                                .read<DoctorListCubit>()
                                .getDoctorById(widget.doctorId);
                            return InfoItem(
                              label: "DOKTER",
                              value: doctor.name,
                            );
                          } catch (e) {
                            return Text(
                                'Error: $e'); // show error message if an error occurred
                          }
                        },
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
                CustomDropdownMenu(
                    list: listSpesialisasi,
                    initialSelection: spesialisasiValue),
                const SizedBox(height: 120),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);

                    int newAppointmentId = await performCreateAppointment();
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => RincianJanjiTemu(
                          appointmentId: newAppointmentId,
                          from: 'periksa_janji_temu',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      40,
                    ),
                  ),
                  child: const Text('Konfirmasi',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<int> performCreateAppointment() async {
    final appointment = AppointmentModel(
      id: 0,
      timestamp: '',
      doctorId: widget.doctorId,
      patientId: widget.patientId,
      date: widget.selectedDate,
      time: widget.scheduleTime,
      coverageType: spesialisasiValue,
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
      // Handle the error
    }
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

class CustomDropdownMenu extends StatefulWidget {
  final List<String> list;
  final String initialSelection;

  const CustomDropdownMenu({
    super.key,
    required this.list,
    required this.initialSelection,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: DropdownMenu<String>(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width - 40,
        initialSelection: widget.initialSelection,
        menuHeight: 200,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
