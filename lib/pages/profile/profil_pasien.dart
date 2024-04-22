import 'package:flutter/material.dart';

class ProfilPasienScreen extends StatefulWidget {
  @override
  _ProfilPasienScreenState createState() => _ProfilPasienScreenState();
}

class _ProfilPasienScreenState extends State<ProfilPasienScreen> {
  String statusMessage = ''; // State untuk menyimpan pesan status

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8; // Lebar container 80% dari layar

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pasien', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'SAYA SENDIRI',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          ),
          // Container dengan lebar 80% dari layar, ditempatkan di tengah
          Center(
            child: Container(
              width: containerWidth,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Hendrick',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '22 Feb 2003',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'john.hendrick@gmail.com',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '08000000000',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      // Mengubah state untuk menampilkan pesan status
                      setState(() {
                        statusMessage = 'Akan Di Proses';
                      });

                      // Menampilkan snackbar dengan pesan
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(statusMessage),
                          duration: Duration(seconds: 2), // Durasi tampilan snackbar
                        ),
                      );
                    },
                    child: Text(
                      'PERMINTAAN PERUBAHAN DATA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Orang Lain',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          ),
           Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Anda belum menambahkan profil untuk orang lain',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
          Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengirim data registrasi
                    },style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('TAMBAH PROFIL LAIN'),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
