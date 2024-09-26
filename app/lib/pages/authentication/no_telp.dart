import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/konfirm_telp.dart';

class NoTelp extends StatefulWidget {
  const NoTelp({super.key});

  @override
  State<NoTelp> createState() => _NoTelpState();
}

class _NoTelpState extends State<NoTelp> {
  bool _isButtonEnabled = false;

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
                  'Masukkan Nomor Telepon',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('Nomor Telepon'),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _isButtonEnabled = value.isNotEmpty;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '085123456789',
                  ),
                ),
                const SizedBox(height: 400.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KonfirmasiTelp(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? Colors.blue[700]
                          : Colors.grey,
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
