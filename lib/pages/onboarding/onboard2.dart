import 'package:flutter/material.dart';

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
<<<<<<< HEAD
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Image.asset(
              'assets/images/onboard2.jpeg',
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              'Buat Janji Temu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Dengan Aplikasi Rumah Sakit kami, Anda dapat dengan mudah membuat janji temu untuk pemeriksaan kesehatan Anda. Tidak perlu lagi antri di loket pendaftaran. Cukup buka aplikasi, pilih waktu yang sesuai, dan janji temu Anda akan segera terdaftar!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
=======
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
>>>>>>> 649f3c6af2e91d0cd77b1c362483bf55ecbef33e
              children: [
                const OnBoardingSlide(
                  image: 'assets/images/janjitemu.png',
                  title: 'Buat Janji Temu',
                  description:
                      'Dengan Aplikasi Rumah Sakit kami, Anda dapat dengan mudah membuat janji temu untuk pemeriksaan kesehatan Anda. Tidak perlu lagi antri di loket pendaftaran. Cukup buka aplikasi, pilih waktu yang sesuai, dan janji temu Anda akan segera terdaftar!',
                  showSkipButton: true, // Menampilkan tombol "Lewati" pada slide pertama
                ),
                const OnBoardingSlide(
                  image: 'assets/images/tanyadokter.png',
                  title: 'Tanya Dokter',
                  description:
                      'Apakah Anda memiliki pertanyaan kesehatan atau ingin berkonsultasi langsung dengan dokter? Aplikasi kami menyediakan layanan konsultasi dokter secara online, memudahkan Anda untuk mendapatkan jawaban atas pertanyaan Anda tanpa harus datang langsung ke rumah sakit.',
                  showSkipButton: false, // slide kedua tidak memerlukan tombol "Lewati"
                ),
              ],
            ),
          ),
          const SizedBox(height: 10), // Penambahan spasi agar tombol tidak terlalu dekat dengan slide
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) => buildDot(index)),
          ),
          const SizedBox(height: 10), // Penambahan spasi agar tombol tidak terlalu dekat dengan indikator slide
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_currentPage != 0 && _currentPage == 1) // hanya menampilkan tombol "Kembali" pada slide pertama saja
                TextButton(
<<<<<<< HEAD
                  onPressed: (){
                    Navigator.pushNamed(context, '/onboard1');
                  },
                  child: const  Text(
                    'Lewati',
                    style: TextStyle(color: Colors.blue)
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/onboard3');
                  },
                  style: ElevatedButton.styleFrom(
=======
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
              if (_currentPage == 0) // Menampilkan tombol "Lewati" hanya pada slide pertama
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/onboard1');
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
>>>>>>> 649f3c6af2e91d0cd77b1c362483bf55ecbef33e
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Penambahan padding di sini
                  child: Text(
                    _currentPage < 1 ? 'Selanjutnya' : 'Mulai',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Penambahan spasi agar tombol tidak terlalu dekat dengan bagian bawah layar
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
  final bool showSkipButton; // Properti untuk menentukan apakah tombol "Lewati" akan ditampilkan

  const OnBoardingSlide({
    required this.image,
    required this.title,
    required this.description,
    this.showSkipButton = false, // Default value untuk properti showSkipButton
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
