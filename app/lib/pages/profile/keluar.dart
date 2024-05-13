import 'package:flutter/material.dart';

class KeluarAplikasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.exit_to_app,
              size: 80.0,
              color: Colors.black,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Keluar Aplikasi',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Apakah kamu yakin ingin keluar aplikasi ATHENA Hospital?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tidak'),
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk keluar dari aplikasi di sini
                  },
                  child: const Text('Ya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
