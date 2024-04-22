import 'package:flutter/material.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Konfirmasi Alamat Email',
      home: KonfirmasiEmail(),
    );
  }
}

class KonfirmasiEmail extends StatefulWidget{
  const KonfirmasiEmail({super.key});

  @override
  State<KonfirmasiEmail> createState() => _KonfirmasiEmailState();
}

class _KonfirmasiEmailState extends State<KonfirmasiEmail>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Konfirmasi Alamat Email',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Kami akan  mengirimkan kode ke alamat email Anda.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            const Text('kelompok7@gmail.com',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24.0),
            const SizedBox(height: 12.0),
            const Text('Kode verifikasi'),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kode Verifikasi',
              ),
            ),
            const SizedBox(height: 12.0),
            const SizedBox(height: 24.0),
            GestureDetector(
				    onTap: () {
				      // Aksi yang akan dijalankan saat "Kirim Ulang Kode" diklik
				      // Misalnya, memulai pengiriman ulang kode
				    },
				    child: const Align(
				      alignment: Alignment.center,
				      child: Text(
				        'Kirim Ulang Kode',
				        style: TextStyle(
				          fontSize: 16.0,
				          color: Colors.purple,
				        ),
				      ),
				    ),
				  ),

            const Align(
              alignment: Alignment.center,
              child: Text(
                'Kirim Ulang dalam 59 Detik.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 200.0),
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
                    const Text('Selanjutnya', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
