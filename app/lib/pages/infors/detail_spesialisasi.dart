import 'package:flutter/material.dart';

class DetailSpesialisasi extends StatelessWidget {
  const DetailSpesialisasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Oftalmologi'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey,
            height: 0.3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Menambahkan margin kanan dan kiri
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/oftalmologi.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Layanan oftalmologi menawarkan saran dan tes medis profesional untuk mengidentifikasi masalah penglihatan Anda dan membantu meningkatkan ketajaman penglihatan. Tim medis kami dilengkapi dengan peralatan diagnostik dan bedah yang berkualitas untuk memberikan perawatan terbaik bagi pasien.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kondisi yang Kami Tangani',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const BulletList(
              items: [
                'Perkembangan Penglihatan Abnormal',
                'Degenerasi Makula Terkait Usia',
                'Amblyopia (Lazy Eye)',
                'Saluran Air Mata Tersumbat',
                'Katarak',
                'Miopia Masa Kanak-kanak',
                'Mata Kering',
                'Gangguan Gerakan Mata dan Penglihatan Ganda',
                'Genetic Disorders',
                'Glaucoma',
                'Infeksi',
                'Tumor Orbital',
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Perawatan & Layanan yang Kami Sediakan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const BulletList(
              items: [
                'Blepharoplasty (Eyelid Surgery)',
                'Operasi Katarak',
                'Operasi Kornea dan Bedah Refraktif',
                'Pengobatan Glaukoma',
                'Operasi Mata LASIK',
                'Layanan Robekan dan Pelepasan Retina',
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '*Harap diperhatikan bahwa ini bukanlah daftar lengkap semua kondisi dan perawatan yang kami sediakan. Informasi ini dimaksudkan sebagai panduan kasar dan bukan sebagai saran medis.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cari_reservasi');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Cari Spesialis',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(item)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
