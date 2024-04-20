import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

class PilihJadwal extends StatefulWidget {
  const PilihJadwal({super.key, required this.title});

  final String title;

  @override
  State<PilihJadwal> createState() => _PilihJadwalState();
}

class _PilihJadwalState extends State<PilihJadwal> {
  DateTime _dates = DateTime.now();
  DateTime now = DateTime.now();
  DateTime selectTime = DateTime(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Pilih Jadwal',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                TimesSlotGridViewFromInterval(
                  locale: "en",
                  initTime: selectTime,
                  crossAxisCount: 4,
                  unSelectedColor: Colors.grey[200],
                  selectedColor: Colors.blue,
                  timeSlotInterval: const TimeSlotInterval(
                    start: TimeOfDay(hour: 14, minute: 00),
                    end: TimeOfDay(hour: 16, minute: 30),
                    interval: Duration(hours: 0, minutes: 15),
                  ),
                  onChange: (value) {
                    setState(() {
                      selectTime = DateTime(
                        _dates.year,
                        _dates.month,
                        _dates.day,
                        value.hour,
                        value.minute,
                      );
                    });
                  },
                ),
                const SizedBox(height: 40),
                const CustomContainer2(
                  dokter: "dr. John Doe, MARS, SpAk",
                  spesialis: "Andrologi - Spesialis Andrologi",
                  imagePath: 'assets/images/dokter/dummy-doctor.jpg',
                ),
                const SizedBox(height: 90),
                ElevatedButton(
                  onPressed: selectTime == DateTime(0)
                      ? null
                      : () {
                          Navigator.pushNamed(
                            context,
                            '/periksa_janji_temu',
                            arguments: {
                              'selectTime': selectTime,
                            },
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
                  child: const Text('Selanjutnya',
                      style: TextStyle(color: Colors.white)),
                )
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
                fontSize: 12,
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
        children: <Widget>[
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
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                spesialis,
                style: const TextStyle(
                  fontSize: 12,
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
