import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
// import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/cubits/doctor_schedule_cubit.dart';
import 'package:tubes/pages/buat_janji_temu/pilih_jadwal.dart';
import 'package:tubes/pages/buat_janji_temu/profil_lengkap_dokter.dart';

class ProfilDokter extends StatefulWidget {
  const ProfilDokter({
    super.key,
    required this.doctorId,
    // required this.doctorName,
    required this.specialization,
    // required this.imagePath,
  });

  final int doctorId;
  // final String doctorName;
  final String specialization;
  // final String imagePath;

  @override
  State<ProfilDokter> createState() => _ProfilDokterState();
}

class _ProfilDokterState extends State<ProfilDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Dokter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 1, // Garis batas
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DoctorListCubit, List<DoctorModel>>(
                  builder: (context, state) {
                    try {
                      DoctorModel doctor = context
                          .read<DoctorListCubit>()
                          .getDoctorById(widget.doctorId);
                      return CustomContainer(
                        id: doctor.id,
                        name: doctor.name,
                        specializationTitle: widget.specialization,
                        imagePath: doctor.imgPath,
                      );
                    } catch (e) {
                      return Text(
                          'Error: $e'); // show error message if an error occurred
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
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
                      const Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 8),
                          Text(
                            'Jadwal Rawat Jalan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 10),
                      const Text(
                        "Athena Hospital Bandung",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Jl. Setiabudhi No. 229, Isola, Sukasari, Kota Bandung, Jawa Barat 40154\n",
                      ),
                      const Text(
                        "Jadwal Regular\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<DoctorScheduleCubit,
                          List<DoctorScheduleModel>>(
                        builder: (context, state) {
                          try {
                            // Get all schedules for the doctor
                            List<DoctorScheduleModel> doctorSchedules = state
                                .where((schedule) =>
                                    schedule.doctorId == widget.doctorId)
                                .toList();

                            // Return a Column with a ScheduleItem for each schedule
                            return Column(
                              children: doctorSchedules.map((schedule) {
                                return ScheduleItem(
                                  day: schedule.day,
                                  time: schedule.time,
                                );
                              }).toList(),
                            );
                          } catch (e) {
                            return Text(
                                'Error: $e'); // show error message if an error occurred
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PilihJadwal(
                                doctorId: widget.doctorId,
                                specialization: widget.specialization,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        child: const Text('Buat Janji Temu',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final int id;
  final String name;
  final String specializationTitle;
  final String imagePath;

  const CustomContainer({
    super.key,
    required this.id,
    required this.name,
    required this.specializationTitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.3),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                offset: Offset(-2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imagePath),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      specializationTitle,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfilLengkapDokter(doctorId: id),
                          ),
                        );
                      },
                      child: Text(
                        'Lihat Profil Lengkap',
                        style: TextStyle(
                          color: Colors.blue[900],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
