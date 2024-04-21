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
//       home: const JanjiTemuSaya2(title: 'Quiz UI'),
//     );
//   }
// }

class JanjiTemuSaya2 extends StatefulWidget {
  const JanjiTemuSaya2({super.key, required this.title});

  final String title;

  @override
  State<JanjiTemuSaya2> createState() => _JanjiTemuSaya2State();
}

class _JanjiTemuSaya2State extends State<JanjiTemuSaya2> {
  int _selectedTabIndex = 0; // Menyimpan indeks teks yang dipilih

  int _currentIndex = 0;

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                          fontSize: 24,
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
                          color: Color.fromRGBO(96, 192, 227, 1),
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
                SizedBox(height: 20),
                _buildIsian()
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_calendar),
              label: 'Janji Temu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information),
              label: 'Rekam Medis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 108, 176, 255),
          unselectedItemColor: const Color.fromARGB(255, 121, 121, 121),
          unselectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 121, 121,
                121), // Warna abu-abu untuk label yang tidak terpilih
          ),
          showUnselectedLabels: true, // Menampilkan label yang tidak terpilih
          onTap: _onItemTapped,
        ));
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
          fontSize: 17,
          color: _selectedTabIndex == index
              ? Colors.white
              : Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }

  Widget _buildIsian() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Janji temu yang akan datang",
            style: TextStyle(fontSize: 17, color: Colors.blue),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/rincian_janji');
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              // margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[50],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(
                        -2, 2), // Moves the shadow to the left and bottom
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_4_outlined,
                        color: Colors.grey,
                      ), // This is
                      SizedBox(width: 8), // This
                      Text(
                        'Rawat Jalan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Hendrick\n11 Mar 2024, 11:00-11.30\ndr. Alvin H Hardjawinata, MARS, SpAk",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Spesialis akupuntur",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                      height:
                          10), // Jarak antara teks "Spesialis akupuntur" dan icon
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12), // Atur padding sesuai kebutuhan
                    decoration: BoxDecoration(
                      color: Colors.yellow, // Atur warna latar belakang
                      borderRadius: BorderRadius.circular(
                          8), // Atur border radius sesuai keinginan
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Silahkan menuju ke front office',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/histori_janji');
            },
            child: Text(
              "LIHAT HISTORI JANJI TEMU",
              style: TextStyle(
                fontSize: 16,
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
