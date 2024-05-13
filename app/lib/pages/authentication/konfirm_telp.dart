import 'package:flutter/material.dart';

class KonfirmasiTelp extends StatefulWidget {
  const KonfirmasiTelp({Key? key}) : super(key: key);

  @override
  State<KonfirmasiTelp> createState() => _KonfirmasiTelpState();
}

class _KonfirmasiTelpState extends State<KonfirmasiTelp> {
  bool _obscureText = true;
  TextEditingController _verificationCodeController = TextEditingController();
  bool _isVerificationCodeEntered = false;

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
                  'Konfirmasi Nomor Telepon',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Kami akan mengirimkan kode ke nomor telepon yang Anda masukkan.',
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(height: 30.0),
                const Text('(+62) 81234567890',
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24.0),
                const SizedBox(height: 12.0),
                const Text('Kode verifikasi'),
                const SizedBox(height: 5.0),
                TextField(
                  controller: _verificationCodeController,
                  obscureText: _obscureText,
                  onChanged: (value) {
                    setState(() {
                      _isVerificationCodeEntered = value.isNotEmpty;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Kode Verifikasi',
                  ),
                ),
                const SizedBox(height: 12.0),
                const SizedBox(height: 24.0),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Kirim Ulang Kode',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.purple,
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
                    onPressed: _isVerificationCodeEntered
                        ? () {
                            Navigator.pushNamed(context, '/welcome_page');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isVerificationCodeEntered
                          ? Colors.blue[700]
                          : Colors.grey, // Tombol berwarna abu-abu jika belum ada input
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        40,
                      ), // 50% dari lebar layar
                    ),
                    child: const Text(
                      'Selanjutnya',
                      style: TextStyle(color: Colors.white),
                    ),
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
