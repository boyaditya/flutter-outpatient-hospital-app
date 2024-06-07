import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/pages/lihat_janji_temu/histori_janji_temu.dart';
import 'package:tubes/pages/profile/detail_profile.dart';
import 'package:tubes/pages/profile/keluar.dart';
import 'package:tubes/pages/profile/syarat_ketentuan.dart';
import 'profil_pasien.dart';
import 'berikan_penilaian.dart';
import 'pusat_bantuan.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profil'),
      ),
      body: Column(
        children: [
          BlocBuilder<PatientListCubit, List<PatientModel>>(
            builder: (context, patients) {
              return SizedBox(
                height: 120.0, // Adjust this value as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProfilPasien(
                              patientId: patient.id,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.blue,
                              child: Text(
                                patient.name[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70, // Adjust this value as needed
                              child: Center(
                                child: Text(
                                  patient.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Pengaturan Akun',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat teks menjadi bold
                fontSize: 14.0, // Ukuran teks
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue, // Warna latar belakang lingkaran
              child: Icon(
                Icons.person,
                color: Colors.white, // Warna ikon di dalam lingkaran
              ),
            ),
            title: const Text('Profil Pasien'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilPasienScreen()),
              );
            },
          ),
					ListTile(
            leading: const Icon(Icons.history, color: Colors.blue, size: 40),
            title: const Text('Riwayat Janji Temu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HistoriJanjiTemu(title: 'Histori Janji Temu',)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.thumb_up, color: Colors.blue, size: 40),
            title: const Text('Berikan Penilaian'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BerikanPenilaianScreen()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.description, color: Colors.blue, size: 40),
            title: const Text('Syarat & Ketentuan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SyaratKetentuanScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue, size: 40),
            title: const Text('Pusat Bantuan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PusatBantuan()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.exit_to_app, color: Colors.blue, size: 40),
            title: const Text('Keluar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeluarAplikasiScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
