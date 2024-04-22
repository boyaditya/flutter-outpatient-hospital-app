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
//       home: RekamMedis(),
//     );
//   }
// }

class RekamMedis extends StatefulWidget {
  const RekamMedis({super.key});

  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  // int _currentIndex = 0;


  String? _selectedDay;
  String? _selectedPoli;
  final List<Map<String, String>> _medicalRecords = [
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '27 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
    },
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '20 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
    },
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '13 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
    },
    // Tambahkan data rekam medis lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_outlined),
        //   onPressed: () {},
        // ),
        title: const Text('Rekam Medis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDay,
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                      iconSize: 15.0,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Hari',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'Hari Ini',
                        'Kemarin',
                        'Minggu Ini',
                        'Bulan Ini',
                        'Bulan Lalu',
                        'Tahun Ini',
                        'Semua'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPoli,
                      onChanged: (value) {
                        setState(() {
                          _selectedPoli = value;
                        });
                      },
                      iconSize: 15.0,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Poli',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'Poli Umum',
                        'Poli Penyakit Dalam',
                        'Poli Anak',
                        'Poli Gigi',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _medicalRecords.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors
                        .white, // Mengubah warna background Card menjadi putih
                    elevation: 2, // Menambahkan sedikit bayangan pada Card
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors
                              .black), // Mengubah warna border menjadi hitam
                      borderRadius: BorderRadius.circular(
                          8.0), // Mengatur radius sudut Card
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _medicalRecords[index]['doctorName']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _medicalRecords[index]['dateTime']!,
                                  ),
                                  Text(
                                    _medicalRecords[index]['poli']!,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: (
                                ) {
                                    Navigator.pushNamed(context, '/detail_rm');
                                  // Aksi tombol lihat detail
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                child: const Text(
                                  'Lihat Detail',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
