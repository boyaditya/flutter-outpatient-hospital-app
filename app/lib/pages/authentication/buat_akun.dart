import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/konfirm_email.dart';

// void main() {
//   runApp(_MyApp());
// }

// class _MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Buat Akun',
//       home: BuatAkun(),
//     );
//   }
// }

class BuatAkun extends StatefulWidget{
  const BuatAkun({super.key});

  @override
  State<BuatAkun> createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun>{
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buat Akun',
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Silakan isi data di bawah ini untuk membuat akun baru. Password harus mengandung minimal 8 karakter termasuk huruf dan nomor.',
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 24.0),
            const Text('Alamat Email'),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'email@domain.com',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('Kata Sandi'),
            const SizedBox(height: 5.0),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kata Sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('Konfirmasi Kata Sandi'),
            const SizedBox(height: 5.0),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kata Sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Dengan menekan "Selanjutnya", Anda menyetujui Syarat & Ketentuan dan Kebijakan Privasi kami.',
              style: TextStyle(fontSize: 11.0),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const KonfirmasiEmail(),
												),
											);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      40), // 50% of screen width
                ),
                child:
                    const Text('Selanjutnya', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
