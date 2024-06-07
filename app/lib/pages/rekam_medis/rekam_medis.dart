import 'package:flutter/material.dart';

class RekamMedis extends StatefulWidget {
  const RekamMedis({super.key});

  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  String? _selectedDay;
  String? _selectedPoli;
  final List<Map<String, String>> _medicalRecords = [
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '27 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
      'patientName': 'July',
    },
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '20 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
      'patientName': 'July',
    },
    {
      'doctorName': 'dr. Medina Gozali',
      'dateTime': '13 Januari 2024, 09:00 WIB',
      'poli': 'Poli Umum',
      'patientName': 'July',
    },
    // Tambahkan data rekam medis lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Rekam Medis'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB( 16.0, 0.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: Colors.black, thickness: 0.2),
            Expanded(
              child: ListView.builder(
                itemCount: _medicalRecords.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue[
                        0], // Mengubah warna background Card menjadi putih
                    elevation: 4, // Menambahkan sedikit bayangan pada Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Mengatur radius sudut Card
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
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Pasien: ${_medicalRecords[index]['patientName']!}',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 3.0,
                                height: 50.0,
                                color: Colors.grey,
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
                                onPressed: () {
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
