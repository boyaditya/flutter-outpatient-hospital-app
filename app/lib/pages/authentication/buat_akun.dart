import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/konfirm_email.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/user_cubit.dart';

class BuatAkun extends StatefulWidget {
  const BuatAkun({super.key});

  @override
  State<BuatAkun> createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  String? _passwordError;
  bool _obscurePasswordText = true;
  bool _obscureConfirmationText = true;
  bool _isEmailEntered = false;
  bool _isPasswordEntered = false;
  bool _isConfirmationEntered = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();

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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email@domain.com',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 12.0),
                const Text('Kata Sandi'),
                const SizedBox(height: 5.0),
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
                const SizedBox(height: 12.0),
                const Text('Konfirmasi Kata Sandi'),
                const SizedBox(height: 5.0),
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
                const SizedBox(height: 24.0),
                const Text(
                  'Dengan menekan "Selanjutnya", Anda menyetujui Syarat & Ketentuan dan Kebijakan Privasi kami.',
                  style: TextStyle(fontSize: 11.0),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _isEmailEntered &&
                            _isPasswordEntered &&
                            _isConfirmationEntered &&
                            _passwordError == null
                        ? () {
                            performRegister(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEmailEntered &&
                              _isPasswordEntered &&
                              _isConfirmationEntered
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
        ],
      ),
    );
  }

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

  Future<void> performRegister(BuildContext context) async {
    try {
      await context.read<UserCubit>().register(
            _emailController.text,
            _passwordController.text,
          );
      showSuccessMessage('Registrasi berhasil');
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const KonfirmasiEmail(),
          ),
        );
      }
    } catch (e) {
      print(e);
      showErrorMessage('Email sudah terdaftar');
      // Handle the error
    }
  }
}
