import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(_MyApp());
// }

// class _MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Rekam Medis',
//       home: DetailRekamMedis(),
//     );
//   }
// }

class DetailRekamMedis extends StatefulWidget{
  const DetailRekamMedis({super.key});

  @override
  State<DetailRekamMedis> createState() => _DetailRekamMedisState();
}


class _DetailRekamMedisState extends State<DetailRekamMedis>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_outlined),
        //   onPressed: (){},
        // ),
        title: const Text('Detail Rekam Medis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor profile picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/images/dokter.jpg',
                    height: 80.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'dr. Medina Gozali',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 3.0,
                          height: 50.0,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8.0),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '27 Januari 2024, 09:00 WIB',
                            ),
                            Text(
                              'Poli Umum',
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Keluhan',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Demam, batuk, nyeri tenggorokan',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Diagnosa',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Influenza dengan pneumonia',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Terapi Obat',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Konsumsi obat oseltamivir, 1 x 1 hari',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Catatan Dokter',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Mulai biasakan istirahat yang cukup dan olahraga yang teratur. Perbanyak minum air putih dan menjaga pola makan.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

