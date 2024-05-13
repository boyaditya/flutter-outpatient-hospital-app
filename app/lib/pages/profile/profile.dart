import 'package:flutter/material.dart';
import 'package:tubes/pages/profile/keluar.dart';
import 'package:tubes/pages/profile/syarat_ketentuan.dart';
import 'hapus_akun.dart';
import 'profil_pasien.dart';
import 'berikan_penilaian.dart';
import 'pusat_bantuan.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profil',
//       home: ProfilScreen(),
//     );
//   }
// }

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profil'),
      ),
      body: Column(
        children: [
          const ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://qph.cf2.quoracdn.net/main-qimg-96794550e18e7d333a311ce0e7ae0dbd-lq',
                  ),
                  radius: 40.0,
                ),
                SizedBox(width: 28.0),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://publicdomainvectors.org/photos/defaultprofile.png',
                  ),
                  radius: 40.0,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Amelia Zalfa',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(width: 23.0),
                Text(
                  'Tambah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Pengaturan Akun',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat teks menjadi bold
                fontSize: 14.0, // Ukuran teks
              ),
            ),
          ),
          ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue, // Warna latar belakang lingkaran
            child: Icon(
              Icons.person,
              color: Colors.white, // Warna ikon di dalam lingkaran
            ),
          ),
          title: const Text('Profil Pasien'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPasienScreen()),
              );
            },
      ),
          ListTile(
            leading: const Icon(Icons.thumb_up, color: Colors.blue, size: 40),
            title: const Text('Berikan Penilaian'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BerikanPenilaianScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.blue, size: 40),
            title: const Text('Syarat & Ketentuan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SyaratKetentuanScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue, size: 40),
            title: const Text('Pusat Bantuan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PusatBantuan()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.blue, size: 40),
            title: const Text('Keluar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeluarAplikasiScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.blue, size: 40),
            title: const Text('Hapus Akun'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HapusAkunScreen()),
              );
            },
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Beranda',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Cari',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.photo_library),
      //       label: 'Media',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu),
      //       label: 'Menu',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profil',
      //     ),
      //   ],
      // ),
    );
  }
}
