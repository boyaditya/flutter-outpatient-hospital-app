import 'package:flutter/material.dart';

class PusatBantuan extends StatelessWidget {
  const PusatBantuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Halo, ada yang bisa kami bantu?',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Divider(
                color: Colors.blue,  // Warna garis divider
                thickness: 2.0,      // Ketebalan garis divider
              ),
              SizedBox(height: 16.0),
              Text(
                'FAQ',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.0),
              
              SizedBox(height: 16.0),
              ExpansionTile(
                title: Text('Bagaimana caranya saya membuat janji temu dengan dokter?'),
                children: [
                  ListTile(
                    title: Text(
                      'Ikuti langkah berikut untuk membuat janji temu pada aplikasi:\n'
                      '1. Pilih "Buat Janji Temu" pada beranda aplikasi\n'
                      '2. Pilih dokter yang tersedia\n'
                      '3. Selanjutnya akan diarahkan ke jadwal dokter\n'
                      '4. Pilih "Buat Janji Temu"\n'
                      '5. Pilih tanggal dan jam janji temu\n'
                      '6. Selanjutnya pilih profil pasien untuk janji temu\n'
                      '7. Periksa detail janji temu dan konfirmasi\n'
                      '8. Janji temu berhasil dibuat dan anda bisa melihat detailnya di bagian menu janji temu',
											style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Bagaimana caranya agar saya bisa menambahkan anggota lain?'),
                children: [
                  ListTile(
                    title: Text(
                      'Anda bisa menambahkan anggota lain dengan cara berikut:\n'
                      '1. Pilih menu "Profil"\n'
                      '2. Pilih "Profil Pasien"\n'
                      '3. Pilih "Tambah Profil Lain"\n'
                      '4. Isi data anggota yang ingin Anda tambahkan\n'
                      '5. Profil anggota lain akan tampil di bagian "Profil Pasien" di bagian "Orang Lain"',
											style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              // ExpansionTile(
              //   title: Text('Penyelesaian masalah dan dukungan'),
              //   children: [
              //     ListTile(
              //       title: Text('Pusat Bantuan'),
              //     ),
              //     ListTile(
              //       title: Text('Hubungi Kami'),
              //     ),
              //   ],
              // ),
              // ExpansionTile(
              //   title: Text('Manajemen Akun'),
              //   children: [
              //     ListTile(
              //       title: Text('Pengaturan Akun'),
              //     ),
              //     ListTile(
              //       title: Text('Keamanan Akun'),
              //     ),
              //   ],
              // ),
              SizedBox(height: 50.0),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.black, size: 30.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          'admin@pusat.co.id',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.black, size: 30.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Telepon',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          '0812345678',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
