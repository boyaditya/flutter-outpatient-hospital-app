import 'package:flutter/material.dart';

class ProfilPasienScreen extends StatefulWidget {
  @override
  _ProfilPasienScreenState createState() => _ProfilPasienScreenState();
}

class _ProfilPasienScreenState extends State<ProfilPasienScreen> {
  String statusMessage = ''; // State untuk menyimpan pesan status

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8; // Lebar container 80% dari layar

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pasien', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'SAYA SENDIRI',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ),
          Center(
						child: TextButton(
							onPressed: () {
								// Fungsi yang akan dijalankan saat tombol ditekan
								// setState(() {
								// 	statusMessage = 'Akan Di Proses';
								// });

								// // Menampilkan snackbar dengan pesan
								// ScaffoldMessenger.of(context).showSnackBar(
								// 	SnackBar(
								// 		content: Text(statusMessage),
								// 		duration: const Duration(seconds: 2), // Durasi tampilan snackbar
								// 	),
								// );
							},
							style: TextButton.styleFrom(
								padding: const EdgeInsets.all(16.0),
								backgroundColor: Colors.blue,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(8.0),
								),
							),
							child: Container(
								width: containerWidth, // Lebar 80% dari layar
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										const Text(
											'John Hendrick',
											style: TextStyle(
												color: Colors.white,
												fontWeight: FontWeight.bold,
											),
										),
										const SizedBox(height: 4.0),
										const Text(
											'22 Feb 2003',
											style: TextStyle(color: Colors.white),
										),
										const SizedBox(height: 4.0),
										const Text(
											'john.hendrick@gmail.com',
											style: TextStyle(color: Colors.white),
										),
										const SizedBox(height: 4.0),
										const Text(
											'08000000000',
											style: TextStyle(color: Colors.white),
										),
										const SizedBox(height: 8.0),
										TextButton(
											onPressed: () {
												// Mengubah state untuk menampilkan pesan status
												setState(() {
													statusMessage = 'Akan Di Proses';
												});

												// Menampilkan snackbar dengan pesan
												ScaffoldMessenger.of(context).showSnackBar(
													SnackBar(
														content: Text(statusMessage),
														duration: const Duration(seconds: 2), // Durasi tampilan snackbar
													),
												);
											},
											style: TextButton.styleFrom(
												padding: EdgeInsets.zero, // Menjaga padding sesuai kebutuhan
												minimumSize: Size.zero, // Menjaga ukuran minimum sesuai kebutuhan
												tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Mengecilkan tap target sesuai ukuran teks
											),
											child: const Text(
												'PERMINTAAN PERUBAHAN DATA',
												style: TextStyle(
													color: Colors.black,
													fontWeight: FontWeight.bold,
													decoration: TextDecoration.underline,
												),
											),
										),
									],
								),
							),
						),
					),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Orang Lain',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ),
           const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Anda belum menambahkan profil untuk orang lain',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
          Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengirim data registrasi
                    },style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('TAMBAH PROFIL LAIN'),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
