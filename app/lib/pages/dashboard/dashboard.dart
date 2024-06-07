// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/cubits/user_cubit.dart';
import 'package:tubes/cubits/doctor_schedule_cubit.dart';

import 'package:tubes/pages/buat_janji_temu/cari_dokter.dart';
import 'package:tubes/pages/infors/infors.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya2.dart';
import 'package:tubes/pages/rekam_medis/rekam_medis.dart';
import 'package:tubes/pages/profile/profile.dart';

import '../../cubits/doctor_cubit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  late Future<void> _fetchDataFuture;

  final List<Widget> _children = [
    const Home(
      title: "Dashboard",
    ),
    const JanjiTemuSaya2(),
    const RekamMedis(),
    ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    await context.read<UserCubit>().fetchUserById();
    await context.read<PatientListCubit>().fetchPatientsByUserId();
    
    await Future.wait([
      context.read<DoctorListCubit>().fetchDoctors(),
      context.read<SpecializationListCubit>().fetchSpecializations(),
      context.read<DoctorScheduleCubit>().fetchDoctorSchedule(),
      context.read<AppointmentCubit>().fetchAppointmentsByPatientId(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchDataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Loading indicator
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
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
              showUnselectedLabels:
                  true, // Menampilkan label yang tidak terpilih
              onTap: _onItemTapped,
            ),
          );
        }
      },
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

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   // Get the PatientListCubit instance
  //   final patientListCubit =
  //       BlocProvider.of<PatientListCubit>(context, listen: false);
  //   // Call the fetchPatientsByUserId function
  //   patientListCubit.fetchPatientsByUserId();
  // }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<PatientListCubit, List<PatientModel>>(
                    builder: (context, patients) {
                      if (patients.isNotEmpty) {
                        PatientModel firstPatient = patients.first;
                        return Text(
                          'Hai, ${firstPatient.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Text(
                          'Hai, User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
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
                autoPlayInterval: const Duration(seconds: 5),
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
                    border: Border.all(
                      color: Colors
                          .grey, // Ganti dengan warna border yang diinginkan
                      width:
                          3.0, // Ganti dengan ketebalan border yang diinginkan
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/carousel/1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/carousel/2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/carousel/3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            DotsIndicator(
              // DotsIndicator widget remains as it is
              dotsCount: 3,
              position: _currentIndex.toInt(),
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
            // CustomButton widgets and other widgets remain as they are
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: Icons.calendar_month_outlined,
                  text1: "Buat",
                  text2: "Janji Temu",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CariDokter(),
                      ),
                    );
                  },
                ),
                CustomButton(
                  icon: Icons.medical_information_rounded,
                  text1: "Informasi",
                  text2: "Rumah Sakit",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InformasiRumahSakit(
                            title: 'Informasi Rumah Sakit'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buat Janji Temu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Dapatkan akses cepat untuk bertemu dengan dokter ahli. Nikmati kemudahan mengatur janji temu kesehatan dengan aplikasi kami.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal padding
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CariDokter(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: AspectRatio(
                      aspectRatio: 16 /
                          8, // Set aspect ratio based on the original image
                      child: Image.asset(
                        'assets/images/janji.png', // Path to your registration image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Extra space added at the end
          ],
        ),
      ),
    );
  }
}
