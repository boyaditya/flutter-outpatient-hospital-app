import 'package:flutter/material.dart';
import 'package:tubes/pages/onboarding/onboard1.dart';

// void main() {
//   runApp(_MyApp());
// }

// class _MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Athena Hospital',
//       home: OnBoarding2(),
//     );
//   }
// }

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  _OnBoarding2State createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                OnBoardingSlide(
                  image: 'assets/images/janjitemu.png',
                  title: 'Buat Janji Temu',
                  description:
                      'Dengan Aplikasi Rumah Sakit kami, Anda dapat dengan mudah membuat janji temu untuk pemeriksaan kesehatan Anda. Tidak perlu lagi antri di loket pendaftaran. Cukup buka aplikasi, pilih waktu yang sesuai, dan janji temu Anda akan segera terdaftar!',
                  showSkipButton: true, // Menampilkan tombol "Lewati" pada slide pertama
                ),
                OnBoardingSlide(
                  image: 'assets/images/rekammedis.png',
                  title: 'Lihat Rekam Medis',
                  description:
                      'Kelola kesehatan Anda dengan mudah dan aman. Aplikasi kami memungkinkan Anda mengakses rekam medis Anda kapan saja dan di mana saja.',
                  showSkipButton: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) => buildDot(index)),
          ),
          const SizedBox(height: 10), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_currentPage != 0 && _currentPage == 1) 
                TextButton(
                  onPressed: () {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  child: const Text(
                    'Kembali',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              if (_currentPage == 0) 
                TextButton(
                  onPressed: () {
                    Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const OnBoarding1(),
												),
											);
                  },
                  child: const Text(
                    'Lewati',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  if (_currentPage < 1) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  } else {
                    Navigator.pushNamed(context, '/onboard1');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), 
                  child: Text(
                    _currentPage < 1 ? 'Selanjutnya' : 'Mulai',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), 
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      width: _currentPage == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnBoardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showSkipButton; 
  const OnBoardingSlide({
    required this.image,
    required this.title,
    required this.description,
    this.showSkipButton = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
