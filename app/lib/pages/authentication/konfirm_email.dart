import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';

class KonfirmasiEmail extends StatefulWidget {
  const KonfirmasiEmail({super.key});

  @override
  State<KonfirmasiEmail> createState() => _KonfirmasiEmailState();
}

class _KonfirmasiEmailState extends State<KonfirmasiEmail> {
  bool _isOtpVerified = false;
  int randomNumber = 10000;
  bool _showNotification = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      random();
    });
  }

  void random() {
    setState(() {
      Random random = new Random();
      randomNumber = random.nextInt(100000);
      _showNotification = true;
    });

    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showNotification = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Email'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Konfirmasi Kode Verifikasi"),
                  const SizedBox(height: 45),
                  const SizedBox(height: 30),
                  OtpTextField(
                    numberOfFields: 5,
                    borderColor: const Color(0xFF512DA8),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      // handle validation or checks here
                    },
                    onSubmit: (String verificationCode) {
                      if (int.parse(verificationCode) == randomNumber) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi Kode Verifikasi Berhasil"),
                                content: const Text(
                                    'Silahkan lanjutkan ke proses selanjutnya'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _isOtpVerified = true;
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi Kode Verifikasi Gagal"),
                                content: const Text('Silahkan coba lagi'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    }, // end onSubmit
                  ),
                  const SizedBox(height: 30),
                  if (_isOtpVerified)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrationScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF512DA8),
                          foregroundColor: const Color(0xFFFFFFFF),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_showNotification)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF512DA8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sms, color: Colors.white, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Kode Verifikasi Anda: $randomNumber',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: random,
        tooltip: 'Refresh Kode Verifikasi',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
