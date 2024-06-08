import 'package:flutter/material.dart';

class HistoriJanjiTemu extends StatefulWidget {
  const HistoriJanjiTemu({super.key, required this.title});

  final String title;

  @override
  State<HistoriJanjiTemu> createState() => _HistoriJanjiTemuState();
}

class _HistoriJanjiTemuState extends State<HistoriJanjiTemu> {
  int _selectedTabIndex = 0; // Menyimpan indeks teks yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(230, 30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Riwayat Janji Temu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 60,
                    right: 20,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(96, 192, 227, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildText("Saya Sendiri", 0),
                            _buildText("Orang Lain", 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 60,
                    right: 240,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _selectedTabIndex == 0 ? 4 : 0,
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 240,
                    right: 50,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _selectedTabIndex == 1 ? 4 : 0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _selectedTabIndex == 0
                      ? Column(
                          children: [
                            _buildAppointmentCard(
                              context,
                              "July",
                              "12 Juni 2024",
                              "Dr. John Doe",
                              "Spesialis Anak",
                            ),
                            const SizedBox(height: 20),
                            _buildAppointmentCard(
                              context,
                              "Siti",
                              "15 Juni 2024",
                              "Dr. Jane Doe",
                              "Spesialis Umum",
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            "Tidak ada data.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 13, 73, 126),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, String patient, String date, String doctor, String specialization) {
    return TextButton(
      onPressed: () {
        // Aksi saat tombol ditekan
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.blue[50],
        shadowColor: Colors.grey,
        elevation: 4,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person_4_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Text(
                  'Rawat Jalan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "$patient\n$date, 10:00 WIB\n$doctor",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              specialization,
              style: const TextStyle(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Aksi saat tombol Lihat Rekam Medis ditekan
              },
              child: const Text("Lihat Rekam Medis"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // Perbarui indeks yang dipilih
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: _selectedTabIndex == index
              ? Colors.white
              : const Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }
}
