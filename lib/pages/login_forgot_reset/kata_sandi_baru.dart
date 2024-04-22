import 'package:flutter/material.dart';

class KataSandiBaru extends StatefulWidget {
  const KataSandiBaru({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _KataSandiBaruState createState() => _KataSandiBaruState();
}

class _KataSandiBaruState extends State<KataSandiBaru> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      setState(() {
        isButtonEnabled = passwordController.text.isNotEmpty;
      });
    });

    confirmPasswordController.addListener(() {
      setState(() {
        isButtonEnabled = confirmPasswordController.text.isNotEmpty;
      });
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordVisibilityConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
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
              'Buat Kata Sandi Baru',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Kata sandi baru Anda harus berbeda dari kata sandi sebelumnya.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Kata Sandi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
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
            const SizedBox(height: 20.0),
            const Text(
              'Konfirmasi Kata Sandi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: _obscureTextConfirm,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Konfirmasi Kata Sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureTextConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibilityConfirm,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 80.0),
            Center(
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.pushNamed(context, '/reset_success');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: const Text('Atur Ulang Kata Sandi',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
