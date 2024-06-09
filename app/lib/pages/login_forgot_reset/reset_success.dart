import 'package:flutter/material.dart';
import 'package:tubes/pages/login_forgot_reset/login.dart';

class ResetSuccess extends StatefulWidget {
  const ResetSuccess({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _ResetSuccessState createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50.0),
            const Center(
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 150,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Center(
              child: Text(
                'Atur Ulang Kata Sandi Berhasil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Center(
              child: Text(
                'Anda telah berhasil mengatur ulang kata sandi Anda',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const Login(),
												),
											);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: const Text('Lanjut',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
