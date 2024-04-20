import 'package:flutter/material.dart';
import 'package:tubes/pages/cari_reservasi.dart';
import 'package:tubes/pages/cari_dokter.dart';
import 'package:tubes/pages/profil_dokter.dart';
import 'package:tubes/pages/profil_lengkap_dokter.dart';
import 'package:tubes/pages/pilih_jadwal.dart';
import 'package:tubes/pages/periksa_janji_temu.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ar', '').then((value) => null);
  initializeDateFormatting('en', '').then((value) => null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) {
        final routeName = ModalRoute.of(context)?.settings.name;

        switch (routeName) {
          case '/':
            return 'Cari & Buat Reservasi';
          case '/cari_dokter':
            return 'Cari Dokter';
          case '/profil_dokter':
            return 'Profil Dokter';
          case '/profil_lengkap_dokter':
            return 'Profil Dokter Lengkap';
          case '/pilih_jadwal':
            return 'Pilih Jadwal';
          case '/periksa_janji_temu':
            return 'Periksa Janji Temu';
          // Add more cases for other routes
          default:
            return 'Cari & Buat Reservasi';
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CariReservasi(title: 'Cari & Buat Reservasi'),
        '/cari_dokter': (context) => const CariDokter(title: 'Cari Dokter'),
        '/profil_dokter': (context) =>
            const ProfilDokter(title: 'Profil Dokter'),
        '/profil_lengkap_dokter': (context) =>
            const ProfilLengkapDokter(title: 'Profil Lengkap Dokter'),
        '/pilih_jadwal': (context) => const PilihJadwal(title: 'Pilih Jadwal'),
        '/periksa_janji_temu': (context) =>
            const PeriksaJanjiTemu(title: 'Periksa Janji Temu'),
        // Add more routes here
      },
    );
  }
}
