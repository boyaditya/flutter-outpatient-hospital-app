import 'package:flutter/material.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Athena Hospital',
      home: OnBoarding1(),
    );
  }
}

class OnBoarding1 extends StatefulWidget{
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Image.asset(
              'assets/athena_bg1.png',
              height: 60,
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/onboard1.jpeg',
              height: 250,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      40), // 50% of screen width
                ),
                child:
                    const Text('Masuk', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                      side: const BorderSide(color: Colors.blue),
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      40), // 50% of screen width
                ),
                child:
                    const Text('Buat Akun', style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}