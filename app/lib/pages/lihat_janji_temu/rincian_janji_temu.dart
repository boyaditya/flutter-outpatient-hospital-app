import 'package:flutter/material.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya2.dart';

class RincianJanjiTemu extends StatefulWidget {
  const RincianJanjiTemu({super.key});


  @override
  State<RincianJanjiTemu> createState() => _RincianJanjiTemuState();
}

class _RincianJanjiTemuState extends State<RincianJanjiTemu> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin membatalkan janji temu?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk membatalkan janji temu di sini
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, List<String> options) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(187, 222, 251, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    title: Text(
                      options[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: index == 1 ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  if (index != options.length - 1)
                    const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                      height: 0,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rincian Janji Temu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Logika ketika tombol butuh bantuan diklik
            },
            icon: const Icon(Icons.help),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Butuh\nBantuan?',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Barcode
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4.0,
                        offset: Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      '../../../assets/images/barcode.png', // Ganti dengan path gambar barcode Anda
                      height: 300, // Sesuaikan dengan kebutuhan
                      width: 300, // Sesuaikan dengan kebutuhan
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                // Teks
                const Text(
                  'Nomor Antrian',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                // Teks bold
                const Text(
                  '16', // Ganti dengan ID Janji Temu yang sesuai
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                const Text(
                  'Pindai kode QR di Kios untuk Check In',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Teks INFO STATUS
                    const Text(
                      "INFO STATUS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Container untuk info status
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 245, 225, 10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            offset: Offset(-2, 2),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Silahkan menuju ke QR Code scanner",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Menunggu verifikasi pasien",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "INFO PASIEN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            offset: Offset(-2, 2),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InfoItem(
                            label: "NAMA LENGKAP",
                            value: "Hanni",
                          ),
                          InfoItem(
                            label: "TANGGAL LAHIR",
                            value: "12 Januari 2004",
                          ),
                          InfoItem(
                            label: "EMAIL",
                            value: "hanni@gmail.com",
                          ),
                          InfoItem(
                            label: "NOMOR PONSEL",
                            value: "081234567890",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "INFO JANJI TEMU",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            offset: Offset(-2, 2),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InfoItem(
                            label: "TANGGAL DAN WAKTU JANJI TEMU",
                            value: "24 April 2024, 14:00 - 16:30",
                          ),
                          InfoItem(
                            label: "DOKTER",
                            value: "dr. John Doe",
                          ),
                          InfoItem(
                            label: "SPESIALIS",
                            value: "Spesialis Akupuntur",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "INFORMASI PENJAMIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            offset: Offset(-2, 2),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Private",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(16, 52, 116, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          40,
                        ),
                      ),
                      child: const Text('Batalkan Janji Temu',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue,
                    //     shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(8))),
                    //     fixedSize: Size(
                    //       MediaQuery.of(context).size.width,
                    //       40,
                    //     ),
                    //   ),
                    //   child: const Text('CHECK IN',
                    //       style: TextStyle(color: Colors.white)),
                    // ),
                    // ElevatedButton(
										// 	onPressed: () {
										// 		_showBottomSheet(context, [
										// 			'Batalkan Janji Temu',
										// 			'Cancel'
										// 		]);
										// 	},
										// 	style: ElevatedButton.styleFrom(
										// 		backgroundColor: Colors.blue[100], // Ganti dengan warna yang diinginkan
										// 		shape: RoundedRectangleBorder(
										// 			borderRadius: BorderRadius.circular(8),
										// 		),
										// 		fixedSize: Size(
										// 			MediaQuery.of(context).size.width,
										// 			40,
										// 		),
										// 	),
										// 	child: const Text(
										// 		'Pilihan Lain',
										// 		style: TextStyle(color: Colors.black),
										// 	),
										// )
										ElevatedButton(
                      onPressed: () {
                        Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => const JanjiTemuSaya2(title: 'Janji Temu Saya 2'),
												),
											);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 80, 130, 215),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          40,
                        ),
                      ),
                      child: const Text('Lihat Halaman Janji Temu',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
