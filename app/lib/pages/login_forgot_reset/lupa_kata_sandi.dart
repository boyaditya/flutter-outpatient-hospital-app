import 'package:flutter/material.dart';
import 'package:tubes/pages/login_forgot_reset/cek_email.dart';

class LupaKataSandi extends StatefulWidget {
  const LupaKataSandi({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _LupaKataSandiState createState() => _LupaKataSandiState();
}

class _LupaKataSandiState extends State<LupaKataSandi> {
  TextEditingController emailController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        isButtonEnabled = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Lupa Kata Sandi Anda?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Masukkan email yang terkait dengan akun Anda dan kami akan mengirimkan email berisi instruksi untuk mengatur ulang kata sandi Anda.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Alamat Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Alamat Email',
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 80.0),
            Center(
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const CekEmail(title: 'Cek Email'),
												),
											);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: const Text('Kirim Email',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
