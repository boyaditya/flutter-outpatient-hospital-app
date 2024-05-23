import 'package:flutter/material.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';

class KonfirmasiEmail extends StatefulWidget {
  const KonfirmasiEmail({super.key});

  @override
  State<KonfirmasiEmail> createState() => _KonfirmasiEmailState();
}

class _KonfirmasiEmailState extends State<KonfirmasiEmail> {
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Konfirmasi Alamat Email',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Kami akan  mengirimkan kode ke alamat email Anda.',
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(height: 30.0),
                const Text('kelompok7@gmail.com',
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24.0),
                const Text('Kode verifikasi'),
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _isButtonEnabled = value.isNotEmpty;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Kode Verifikasi',
                  ),
                ),
                const SizedBox(height: 12.0),
                const SizedBox(height: 24.0),
                GestureDetector(
                  onTap: () {
                    // Aksi yang akan dijalankan saat "Kirim Ulang Kode" diklik
                    // Misalnya, memulai pengiriman ulang kode
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Kirim Ulang dalam 59 Detik.',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 200.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrationScreen(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? Colors.blue[700]
                          : Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      fixedSize: Size(MediaQuery.of(context).size.width,
                          40), // 50% of screen width
                    ),
                    child: const Text('Selanjutnya',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
