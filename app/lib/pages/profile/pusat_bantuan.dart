import 'package:flutter/material.dart';

class PusatBantuan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Halo, ada yang bisa kami bantu?',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Divider(
                color: Colors.blue,  // Warna garis divider
                thickness: 2.0,       // Ketebalan garis divider
              ),
              SizedBox(height: 16.0),
              Text(
                'FAQ',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.0),
              
              SizedBox(height: 16.0),
              ExpansionTile(
                title: Text('Memulai'),
                children: [
                  ListTile(
                    title: Text('Panduan Penggunaan'),
                  ),
                  ListTile(
                    title: Text('Persyaratan Sistem'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Fitur dan Kegiatan'),
                children: [
                  ListTile(
                    title: Text('Fitur Utama'),
                  ),
                  ListTile(
                    title: Text('Kegiatan Terakhir'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Penyelesaian masalah dan dukungan'),
                children: [
                  ListTile(
                    title: Text('Pusat Bantuan'),
                  ),
                  ListTile(
                    title: Text('Hubungi Kami'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Manajemen Akun'),
                children: [
                  ListTile(
                    title: Text('Pengaturan Akun'),
                  ),
                  ListTile(
                    title: Text('Keamanan Akun'),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.black, size: 30.0),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'admin@pusat.co.id',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.black, size: 30.0),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telepon',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        '0812345678',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
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
