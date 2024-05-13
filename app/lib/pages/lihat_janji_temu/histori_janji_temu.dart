import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Quiz UI',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HistoriJanjiTemu(title: 'Quiz UI'),
//     );
//   }
// }

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
                      "Histori Janji Temu",
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
                      width:
                          400, // Add this line to set the width of the Container
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
                    left: 60, // Atur posisi awal ke tepi kiri
                    right: 240, // Atur posisi akhir ke tepi kanan
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height:
                          _selectedTabIndex == 0 ? 4 : 0, // Set lebar awal ke 0

                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 240, // Atur posisi awal ke tepi kiri
                    right: 50, // Atur posisi akhir ke tepi kanan
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height:
                          _selectedTabIndex == 1 ? 4 : 0, // Set lebar awal ke 0

                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 220),
                  child: Text(
                    "Tidak ada data.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 13, 73, 126),
                        fontWeight:
                            FontWeight.bold), // Menentukan tebalnya teks),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
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
              : Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }
}
