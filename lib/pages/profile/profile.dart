import 'package:flutter/material.dart';
import 'package:tubes/keluar.dart';
import 'package:tubes/syarat_ketentuan.dart';
import 'hapus_akun.dart';
import 'profil_pasien.dart';
import 'berikan_penilaian.dart';
import 'pusat_bantuan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil',
      home: ProfilScreen(),
    );
  }
}

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        children: [
          ListTile(
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
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 23.0),
                Text(
                  'Tambah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
              ],
            ),
          ),
          Divider(),
          Padding(
           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Pengaturan Akun',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat teks menjadi bold
                fontSize: 16.0, // Ukuran teks
              ),
            ),
          ),
          ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue, // Warna latar belakang lingkaran
            child: Icon(
              Icons.person,
              color: Colors.white, // Warna ikon di dalam lingkaran
            ),
          ),
          title: Text('Profil Pasien'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPasienScreen()),
              );
            },
      ),
          ListTile(
            leading: Icon(Icons.thumb_up, color: Colors.blue, size: 40),
            title: Text('Berikan Penilaian'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BerikanPenilaianScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.description, color: Colors.blue, size: 40),
            title: Text('Syarat & Ketentuan'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SyaratKetentuanScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.blue, size: 40),
            title: Text('Pusat Bantuan'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PusatBantuan()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue, size: 40),
            title: Text('Keluar'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeluarAplikasiScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.blue, size: 40),
            title: Text('Hapus Akun'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HapusAkunScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}