import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/cubits/user_cubit.dart';
import 'package:tubes/pages/login_forgot_reset/reset_success.dart';

class KataSandiBaru extends StatefulWidget {
  const KataSandiBaru({super.key});

  @override
  State<KataSandiBaru> createState() => _KataSandiBaruState();
}

class _KataSandiBaruState extends State<KataSandiBaru> {
  String? _passwordError;
  bool _obscurePasswordText = true;
  bool _obscureConfirmationText = true;
  bool _isPasswordEntered = false;
  bool _isConfirmationEntered = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _toggleConfirmationVisibility() {
    setState(() {
      _obscureConfirmationText = !_obscureConfirmationText;
    });
  }

  void _validatePasswords() {
    final password = _passwordController.text;
    final confirmation = _confirmationController.text;

    if (password != confirmation) {
      _passwordError = 'Kata sandi tidak cocok';
    } else if (password.length < 8) {
      _passwordError = 'Password harus terdiri dari minimal 8 karakter';
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
        .hasMatch(password)) {
      _passwordError = 'Password harus mengandung huruf dan angka';
    } else {
      _passwordError = null;
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Password harus mengandung minimal 8 karakter termasuk huruf dan nomor.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
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
              controller: _passwordController,
              obscureText: _obscurePasswordText,
              onChanged: (value) {
                setState(() {
                  _isPasswordEntered = value.isNotEmpty;
                  _validatePasswords();
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kata Sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePasswordText
                        ? Icons.visibility_off
                        : Icons.visibility,
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
                fontSize: 12,
              ),
            ),
            TextField(
              controller: _confirmationController,
              obscureText: _obscureConfirmationText,
              onChanged: (value) {
                setState(() {
                  _isConfirmationEntered = value.isNotEmpty;
                  _validatePasswords();
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Konfirmasi Kata Sandi',
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmationText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _toggleConfirmationVisibility,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 80.0),
            Center(
              child: ElevatedButton(
                onPressed: _isPasswordEntered &&
                        _isConfirmationEntered &&
                        _passwordError == null
                    ? () {
                        performResetPassword();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPasswordEntered && _isConfirmationEntered
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
                  'Atur Ulang Kata Sandi',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performResetPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      print(  _passwordController.text);
      print(email);
      await context.read<UserCubit>().resetPassword(
            email!,
            _passwordController.text,
          );

      if (!mounted) return;
      showSuccessMessage('Kata sandi berhasil diatur ulang');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetSuccess(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // print(e);
      showErrorMessage(' Terjadi kesalahan saat mengatur ulang kata sandi');
      // Handle the error
    }
  }
}
