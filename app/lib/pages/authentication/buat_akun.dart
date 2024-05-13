import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/konfirm_email.dart';

class BuatAkun extends StatefulWidget {
  const BuatAkun({Key? key}) : super(key: key);

  @override
  State<BuatAkun> createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  bool _obscureText = true;
  bool _isEmailEntered = false;
  bool _isPasswordEntered = false;
  bool _isConfirmationEntered = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            TextField(
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  _isEmailEntered = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'email@domain.com',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('Kata Sandi'),
            const SizedBox(height: 5.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              onChanged: (value) {
                setState(() {
                  _isPasswordEntered = value.isNotEmpty;
                });
              },
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
              controller: _confirmationController,
              obscureText: _obscureText,
              onChanged: (value) {
                setState(() {
                  _isConfirmationEntered = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Konfirmasi Kata Sandi',
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
                onPressed: _isEmailEntered && _isPasswordEntered && _isConfirmationEntered
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KonfirmasiEmail(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEmailEntered && _isPasswordEntered && _isConfirmationEntered
                      ? Colors.blue[700]
                      : Colors.grey, // Warna abu-abu jika input belum diisi
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    40,
                  ), // Lebar 50% dari lebar layar
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
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
