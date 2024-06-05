import 'package:flutter/material.dart';
import 'package:tubes/pages/profile/detail_profile.dart';
import 'package:tubes/pages/profile/edit_profile.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';


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
                Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => DetailProfilPasien(),
													),
												);
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
												Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => const EditProfileScreen(),
													),
												);
											},
											style: TextButton.styleFrom(
												tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
          const SizedBox(height: 5.0), // Jarak tambahan sebelum tombol "Tambah Profil Lain"
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => const RegistrationScreen(),
													),
												);
                },
                style: ElevatedButton.styleFrom(
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
