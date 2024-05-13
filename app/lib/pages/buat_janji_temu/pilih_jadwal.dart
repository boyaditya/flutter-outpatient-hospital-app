import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class PilihJadwal extends StatefulWidget {
  const PilihJadwal({super.key, required this.title});

  final String title;

  @override
  State<PilihJadwal> createState() => _PilihJadwalState();
}

class _PilihJadwalState extends State<PilihJadwal> {
  DateTime _dates = DateTime(0);
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Pilih Jadwal',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
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
                      selectableDayPredicate: (date) {
                        // Senin adalah hari ke-1 dan Rabu adalah hari ke-3
                        return date.weekday == 1 || date.weekday == 3;
                      },
                    ),
                    value: [_dates],
                    onValueChanged: (dates) {
                      if (dates.isNotEmpty) {
                        setState(() {
                          _dates = dates.first!;
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Text(
                        "Jadwal Regular\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ScheduleItem(day: "Senin", time: "14:00 - 16:30"),
                      ScheduleItem(day: "Rabu", time: "14:00 - 16:30"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomContainer2(
                  dokter: "dr. John Doe, MARS, SpAk",
                  spesialis: "Andrologi - Spesialis Andrologi",
                  imagePath: 'assets/images/dokter/dummy-doctor.jpg',
                ),
                const SizedBox(height: 90),
                ElevatedButton(
                  onPressed: _dates == DateTime(0)
                      ? null
                      : () {
                          Navigator.pushNamed(context, '/profil_pasien');
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
                  child: const Text('Selanjutnya',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
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

class CustomContainer2 extends StatelessWidget {
  final String dokter;
  final String spesialis;
  final String imagePath;

  const CustomContainer2({
    super.key,
    required this.dokter,
    required this.spesialis,
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
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dokter,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                spesialis,
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
