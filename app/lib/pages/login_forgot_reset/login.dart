// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/buat_akun.dart';
import 'package:tubes/pages/dashboard/dashboard.dart';
import 'package:tubes/pages/login_forgot_reset/lupa_kata_sandi.dart';

class Login extends StatefulWidget {
  const Login({super.key, required String title});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        isButtonEnabled = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      setState(() {
        isButtonEnabled = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      });
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 150,
                height: 150,
              ),
            ),
            const Center(
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
            const Text(
              'Kata Sandi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            TextField(
              controller: passwordController,
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
            const SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const Dashboard(title: 'Dashboard'),
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
                child:
                    const Text('Masuk', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
										context,
										MaterialPageRoute(
											builder: (context) => const LupaKataSandi(title: 'Lupa Kata Sandi'),
										),
									);
                },
                child: const Text('Lupa Kata Sandi?',
                    style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum punya akun?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const BuatAkun(),
												),
											);
                  },
                  child: const Text('Daftar Sekarang',
                      style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
