import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ophthalmology',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DetailSpesialisasi(),
//     );
//   }
// }

class DetailSpesialisasi extends StatelessWidget {
  const DetailSpesialisasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_outlined),
        //   onPressed: () {},
        // ),
        title: const Text('Ophthalmology'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey,
            height: 0.3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Menambahkan margin kanan dan kiri
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/oftalmologi.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Siloam Hospitals\' Ophthalmologic services offer professional medical advice and tests to identify your vision problems and help improve the acuity. Our medical team is equipped with quality diagnostic and surgical equipment to deliver the best treatment for patients.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Conditions We Treat',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const BulletList(
              items: [
                'Abnormal Vision Development',
                'Age-related Macular Degeneration',
                'Amblyopia (Lazy Eye)',
                'Blocked Tear Ducts',
                'Cataracts',
                'Childhood Myopia',
                'Dry Eyes',
                'Eye Movement Disorders and Double Vision',
                'Genetic Disorders',
                'Glaucoma',
                'Infections',
                'Orbital Tumors',
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Treatments & Services We Provide',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const BulletList(
              items: [
                'Blepharoplasty (Eyelid Surgery)',
                'Cataract Surgery',
                'Cornea and Refractive Surgery',
                'Glaucoma Treatment',
                'LASIK Eye Surgery',
                'Retinal Tear and Detachment Services',
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '*Please note that this is not a complete list of all the conditions and treatments that we provide. The information is intended as rough guidelines and not for medical advice.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cari_reservasi');
                  // handle the button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cari Spesialis',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(item)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
