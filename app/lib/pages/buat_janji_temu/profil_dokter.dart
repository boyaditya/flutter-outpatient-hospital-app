import 'package:flutter/material.dart';
import 'package:tubes/pages/buat_janji_temu/pilih_jadwal.dart';
import 'package:tubes/pages/buat_janji_temu/profil_lengkap_dokter.dart';

class ProfilDokter extends StatefulWidget {
  const ProfilDokter({super.key, required this.title});

  final String title;

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
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomContainer(
                  dokter: "dr. John Doe, MARS, SpAk",
                  spesialis: "Andrologi - Spesialis Andrologi",
                  imagePath: 'assets/images/dokter/dummy-doctor.jpg',
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
                      const ScheduleItem(day: "Senin", time: "14:00 - 16:30"),
                      const ScheduleItem(day: "Rabu", time: "14:00 - 16:30"),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
														context,
														MaterialPageRoute(
															builder: (context) => const PilihJadwal(title: 'Pilih Jadwal'),
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
  final String dokter;
  final String spesialis;
  final String imagePath;

  const CustomContainer({
    super.key,
    required this.dokter,
    required this.spesialis,
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
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dokter,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    spesialis,
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
													builder: (context) => const ProfilLengkapDokter(title: 'Profil Lengkap Dokter'),
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
            ],
          ),
        ),
      ],
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
