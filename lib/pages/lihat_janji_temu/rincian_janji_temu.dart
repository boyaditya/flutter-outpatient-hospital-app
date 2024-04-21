import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Quiz UI',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const RincianJanjiTemu(title: 'Quiz UI'),
//     );
//   }
// }

class RincianJanjiTemu extends StatefulWidget {
  const RincianJanjiTemu({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RincianJanjiTemu> createState() => _RincianJanjiTemuState();
}

class _RincianJanjiTemuState extends State<RincianJanjiTemu> {
  void _showBottomSheet(BuildContext context, List<String> options) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
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
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    title: Text(
                      options[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: index == 1 ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  if (index != options.length - 1)
                    Divider(
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Logika ketika tombol butuh bantuan diklik
            },
            icon: Icon(Icons.help),
          ),
          // Teks di sebelah kanan ikon
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Butuh\nBantuan?',
              style: TextStyle(fontSize: 16),
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
                SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                // Teks
                Text(
                  'Nomor Antrian',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                // Teks bold
                Text(
                  '16', // Ganti dengan ID Janji Temu yang sesuai
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Teks
                Text(
                  'Kode Booking',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                // Teks bold
                Text(
                  'T6NWHR', // Ganti dengan Nomor Antrian yang sesuai
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8), // Berikan jarak antara teks berikutnya
                Text(
                  'Pindai kode QR di Kios untuk Check In',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Mengubah crossAxisAlignment menjadi start
                  children: [
                    // Teks INFO STATUS
                    Text(
                      "INFO STATUS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Container untuk info status
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 245, 225, 10),
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
                      // Kolom untuk konten info status
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Teks pertama
                          Text(
                            "Silahkan menuju ke front office",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              height:
                                  8), // Berikan jarak antara teks berikutnya
                          // Teks kedua
                          Text(
                            "Menunggu verifikasi pasien",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
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
                            value: "John Doe",
                          ),
                          InfoItem(
                            label: "TANGGAL LAHIR",
                            value: "12 Januari 1990",
                          ),
                          InfoItem(
                            label: "EMAIL",
                            value: "johnhendrick@gmail.com",
                          ),
                          InfoItem(
                            label: "NOMOR PNSEL",
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
                            value: "12 Januari 2022, 10:00 WIB",
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(16, 52, 116, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          40,
                        ),
                      ),
                      child: const Text('TAMBAHKAN KE KALENDER SAYA',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          40,
                        ),
                      ),
                      child: const Text('CHECK IN',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, [
                            'Jadwal Ulang Janji Temu',
                            'Batalkan Janji Temu',
                            'Cancel'
                          ]);
                        },
                        child: Text(
                          "PILIHAN LAIN",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
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
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
