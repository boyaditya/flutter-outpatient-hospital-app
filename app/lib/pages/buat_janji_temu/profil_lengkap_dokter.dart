import 'package:flutter/material.dart';

class ProfilLengkapDokter extends StatefulWidget {
  const ProfilLengkapDokter({super.key, required this.title});

  final String title;

  @override
  State<ProfilLengkapDokter> createState() => _ProfilDokterLengkapState();
}

class _ProfilDokterLengkapState extends State<ProfilLengkapDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Lengkap Dokter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(90),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 70),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(10),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/dokter/dummy-doctor.jpg'),
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  Text(
                    'dr. John Doe, MARS, SpAk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Andrologi - Spesialis Andrologi',
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[50],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                      offset: Offset(
                          -2, 2), // Moves the shadow to the left and bottom
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_information), // This is
                        SizedBox(width: 8), // This
                        Text(
                          'Kondisi & Minat Klinis',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        "-dr. John Doe, MARS, SpAk merupakan seorang Dokter Spesialis Andrologi. Saat ini dr. Hermawan Ludirja berpraktek di X. Sebagai seorang dokter, beliau telah mengenyam pendidikan Spesialis di Universitas X.\n"),
                    Text("- Pemeriksaan sperma"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[50],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                      offset: Offset(
                          -2, 2), // Moves the shadow to the left and bottom
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school), // This is
                        SizedBox(width: 8), // This
                        Text(
                          'Pendidikan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        "- Kedokteran Umum, Fakultas Kedokteran Universitas X (1979)\n"),
                    Text("- Spesialis Andrologi, Universitas Y (1979)"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
