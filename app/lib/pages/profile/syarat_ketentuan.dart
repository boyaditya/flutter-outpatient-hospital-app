import 'package:flutter/material.dart';

class SyaratKetentuanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat & Ketentuan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/athena_bg1.png',
                width: 120.0, // Sesuaikan ukuran logo sesuai kebutuhan
                height: 120.0,
                // Jika perlu, tambahkan properti fit untuk menyesuaikan tata letak gambar
              ),
            ),
            Divider(
                color: Colors.blue,  // Warna garis divider
                thickness: 4.0,       // Ketebalan garis divider
              ),
            SizedBox(height: 10.0),
            Text(
              'Syarat & Ketentuan ATHENA Hospital',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Selamat datang di aplikasi resmi ATHENA Hospital. Dengan menggunakan aplikasi ini, Anda dianggap telah membaca, memahami, dan menyetujui syarat dan ketentuan berikut:',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Penggunaan aplikasi ini tunduk pada hukum yang berlaku di wilayah negara tempat Anda berada.\n\n2. Informasi yang diberikan melalui aplikasi ini hanya untuk tujuan informasi dan bukan pengganti saran medis profesional.\n\n3. Anda bertanggung jawab penuh atas keamanan data pribadi yang Anda berikan melalui aplikasi ini.\n\n4. Penggunaan aplikasi ini mengindikasikan persetujuan Anda terhadap kebijakan privasi kami.\n\n5. Dilarang keras menggunakan aplikasi ini untuk kegiatan ilegal atau melanggar hukum negara.\n\nTerima kasih atas kunjungan Anda di ATHENA Hospital. Silakan hubungi layanan pelanggan kami jika Anda memiliki pertanyaan lebih lanjut.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
