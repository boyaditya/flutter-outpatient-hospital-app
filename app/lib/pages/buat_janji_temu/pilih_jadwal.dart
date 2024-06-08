import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/doctor_schedule_cubit.dart';
// import 'package:tubes/pages/buat_janji_temu/profil_dokter.dart';
import 'package:tubes/pages/buat_janji_temu/profil_pasien.dart';

class PilihJadwal extends StatefulWidget {
  const PilihJadwal({
    super.key,
    required this.doctorId,
    required this.specialization,
  });

  final int doctorId;
  final String specialization;

  @override
  State<PilihJadwal> createState() => _PilihJadwalState();
}

class _PilihJadwalState extends State<PilihJadwal> {
  DateTime _dates = DateTime(0);
  DateTime now = DateTime.now();
  late Future<List<DoctorScheduleModel>> futureSchedule;
  List<int> days = [];
  Map<int, String> scheduleTimeMap = {};

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // futureSchedule = context
    //     .read<DoctorScheduleCubit>()
    //     .fetchDoctorScheduleByDoctorId(widget.doctorId);
    // futureSchedule.then((schedule) {
    //   setState(() {
    //     // Mapping from Bahasa days to weekday numbers
    //     Map<String, int> dayToNumber = {
    //       'Minggu': 0,
    //       'Senin': 1,
    //       'Selasa': 2,
    //       'Rabu': 3,
    //       'Kamis': 4,
    //       'Jumat': 5,
    //       'Sabtu': 6,
    //     };

    //     days = schedule.map((item) => dayToNumber[item.day]!).toList();
    //     scheduleTimeMap = {
    //       for (var item in schedule) dayToNumber[item.day]!: item.time
    //     };
    //   });
    // });

    String dateString = _dates.toIso8601String().split('T')[0];
    String? scheduleTime = scheduleTimeMap[_dates.weekday];
    // print(dateString);
    // print(scheduleTimeMap);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Pilih Jadwal',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      selectedDayHighlightColor: Colors.blue,
                      firstDate: DateTime.now(),
                      weekdayLabels: [
                        'Minggu',
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                      ],
                      selectableDayPredicate: (date) {
                        // Senin adalah hari ke-1 dan Rabu adalah hari ke-3
                        return days.contains(date.weekday);
                      },
                    ),
                    value: [_dates],
                    onValueChanged: (dates) {
                      if (dates.isNotEmpty) {
                        setState(() {
                          _dates = dates.first!;
                          scheduleTime = scheduleTimeMap[_dates.weekday];
                          print(scheduleTime);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
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
                      const SizedBox(height: 6),
                      const Text(
                        "Jadwal Regular\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<DoctorScheduleCubit,
                          List<DoctorScheduleModel>>(
                        builder: (context, state) {
                          // Get all schedules for the doctor
                          List<DoctorScheduleModel> doctorSchedules = context
                              .read<DoctorScheduleCubit>()
                              .getDoctorScheduleByDoctorId(widget.doctorId);

                          // Mapping from Bahasa days to weekday numbers
                          Map<String, int> dayToNumber = {
                            'Minggu': 0,
                            'Senin': 1,
                            'Selasa': 2,
                            'Rabu': 3,
                            'Kamis': 4,
                            'Jumat': 5,
                            'Sabtu': 6,
                          };

                          days = doctorSchedules
                              .map((item) => dayToNumber[item.day]!)
                              .toList();
                          scheduleTimeMap = {
                            for (var item in doctorSchedules)
                              dayToNumber[item.day]!: item.time
                          };

                          // Use the 'days' and 'scheduleTimeMap' variables here to build your widget
                          // ...
                          return Column(
                            children: doctorSchedules.map((item) {
                              return ScheduleItem(
                                day: item.day,
                                time: item.time,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<DoctorListCubit, List<DoctorModel>>(
                  builder: (context, state) {
                    try {
                      DoctorModel doctor = context
                          .read<DoctorListCubit>()
                          .getDoctorById(widget.doctorId);
                      return DoctorContainer(
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _dates == DateTime(0)
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilPasien(
                          selectedDate: dateString,
                          scheduleTime: scheduleTime!,
                          doctorId: widget.doctorId,
                          specialization: widget.specialization),
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
            'Selanjutnya',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorContainer extends StatelessWidget {
  final String name;
  final String specializationTitle;
  final String imagePath;

  const DoctorContainer({
    super.key,
    required this.name,
    required this.specializationTitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imagePath),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                specializationTitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String day;
  final String time;

  const ScheduleItem({
    super.key,
    required this.day,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(day),
              Text(time),
            ],
          ),
        ),
        const Divider(color: Colors.black),
      ],
    );
  }
}
