import 'package:flutter/material.dart';

class KeluarAplikasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 80.0,
              color: Colors.black,
            ),
            SizedBox(height: 16.0),
            Text(
              'Keluar Aplikasi',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Apakah kamu yakin ingin keluar aplikasi ATHENA Hospital?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tidak'),
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.grey,
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk keluar dari aplikasi di sini
                  },
                  child: Text('Ya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}