import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
// import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya1.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya2.dart';
import 'package:tubes/pages/rekam_medis/rekam_medis.dart';
import 'package:tubes/pages/profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});
  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  // int _selectedIndex = 0;

  final List<Widget> _children = [
    const Dashboard1(
      title: "Dashboard",
    ),
    const JanjiTemuSaya2(title: "Janji Temu Saya 2"),
    const RekamMedis(),
    ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
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
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 108, 176, 255),
        unselectedItemColor: const Color.fromARGB(255, 121, 121, 121),
        unselectedLabelStyle: const TextStyle(
          color: Color.fromARGB(255, 121, 121,
              121), // Warna abu-abu untuk label yang tidak terpilih
        ),
        showUnselectedLabels: true, // Menampilkan label yang tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 227, 255),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dashboard1 extends StatefulWidget {
  const Dashboard1({super.key, required this.title});
  final String title;

  @override
  State<Dashboard1> createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  int _currentIndex = 0;

  // int _selectedIndex = 0;

  // final List<Widget> _children = [
  //   const Dashboard1(
  //     title: "Dashboard",
  //   ),
  //   const JanjiTemuSaya2(title: "Janji Temu Saya 2"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/athena_bg1.png',
              height: 32,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hi, User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_active),
                  onPressed: () {
                    // Action when notification icon is pressed
                  },
                ),
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: [
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/dokter.jpg'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          DotsIndicator(
            dotsCount: 3,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.blue,
              spacing: const EdgeInsets.all(2.0),
              activeSize: const Size(80.0, 8.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              CustomButton(
                icon: Icons.edit_calendar_rounded,
                text1: "Buat",
                text2: "Janji Temu",
                onPressed: () {
                  Navigator.pushNamed(context, '/cari_reservasi');
                },
              ),
              CustomButton(
                icon: Icons.calendar_month_outlined,
                text1: "Jadwal",
                text2: "Dokter",
                onPressed: () {
                  Navigator.pushNamed(context, '/cari_dokter');
                },
              ),
              CustomButton(
                icon: Icons.medical_information_rounded,
                text1: "Informasi",
                text2: "Rumah Sakit",
                onPressed: () {
                  Navigator.pushNamed(context, '/informasi_rumah_sakit');
                },
              ),
              CustomButton(
                icon: Icons.account_circle,
                text1: "Registrasi",
                text2: "Pasien Baru",
                onPressed: () {
                  Navigator.pushNamed(context, '/registrasi_pasien');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
