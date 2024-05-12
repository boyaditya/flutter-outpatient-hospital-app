import 'package:flutter/material.dart';

// void main() {
//   runApp(_MyApp());
// }

// class _MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Konfirmasi Nomor Telepon',
//       home: KonfirmasiTelp(),
//     );
//   }
// }

class KonfirmasiTelp extends StatefulWidget {
  const KonfirmasiTelp({super.key});

  @override
  State<KonfirmasiTelp> createState() => _KonfirmasiTelpState();
}

class _KonfirmasiTelpState extends State<KonfirmasiTelp> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios_outlined),
          //   onPressed: (){},
          // ),
          ),
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Kami akan  mengirimkan kode ke nomor telepon yang Anda masukan.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 30.0),
                const Text('(+62) 8106454127',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24.0),
                const SizedBox(height: 12.0),
                const Text('Kode verifikasi'),
                const SizedBox(height: 5.0),
                TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Kode Verifikasi',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                const SizedBox(height: 24.0),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Kirim Ulang Kode',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.purple,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Kirim Ulang dalam 59 Detik.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 200.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome_page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
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
