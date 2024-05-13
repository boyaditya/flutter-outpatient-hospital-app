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
//       home: const JanjiTemuSaya1(title: 'Quiz UI'),
//     );
//   }
// }

class JanjiTemuSaya1 extends StatefulWidget {
  const JanjiTemuSaya1({super.key, required this.title});

  final String title;

  @override
  State<JanjiTemuSaya1> createState() => _JanjiTemuSaya1State();
}

class _JanjiTemuSaya1State extends State<JanjiTemuSaya1> {
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
                      "Janji Temu Saya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 56,
                    right: 20,
                    child: Container(
                      width:
                          400, // Add this line to set the width of the Container
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(96, 192, 227, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildText("Semua", 0),
                            _buildText("Saya Sendiri", 1),
                            _buildText("Orang Lain", 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(child: _buildCalendarSection()),
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
              : const Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          const Icon(
            Icons.edit_calendar,
            size: 40,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Anda tidak memiliki janji\nyang akan datang",
              style: TextStyle(fontSize: 15, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/histori_janji');
            },
            child: const Text(
              "LIHAT HISTORI JANJI TEMU",
              style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 3, 48, 85),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
