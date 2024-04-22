import 'package:flutter/material.dart';
import 'detail_spesialisasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spesialisasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Spesialisasi(),
    );
  }
}

class Spesialisasi extends StatelessWidget {
  const Spesialisasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Spesialisasi',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: 'Cari Spesialisasi',
                  hintStyle: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: Icons.remove_red_eye,
                  text: 'Oftalmologi',
                  onPressed: () {Navigator.push(
															context,
															MaterialPageRoute(builder: (context) => OphthalmologyPage()),
														);},
                ),
                CustomButton(
                  icon: Icons.remove_red_eye,
                  text: 'Oftalmologi',
                  onPressed: () {},
                ),
                CustomButton(
                  icon: Icons.remove_red_eye,
                  text: 'Oftalmologi',
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 227, 255),
                shape: BoxShape.rectangle,
								borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
