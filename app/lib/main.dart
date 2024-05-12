import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tubes/pages/authentication/buat_akun.dart';
import 'package:tubes/pages/authentication/data_diri.dart';
import 'package:tubes/pages/authentication/konfirm_email.dart';
import 'package:tubes/pages/authentication/konfirm_telp.dart';
import 'package:tubes/pages/authentication/no_telp.dart';
import 'package:tubes/pages/authentication/welcome_page.dart';
import 'package:tubes/pages/infors/infors.dart';
import 'package:tubes/pages/infors/spesialisasi.dart';
import 'package:tubes/pages/infors/detail_spesialisasi.dart';

import 'package:tubes/pages/buat_janji_temu/cari_reservasi.dart';
import 'package:tubes/pages/buat_janji_temu/cari_dokter.dart';
import 'package:tubes/pages/buat_janji_temu/profil_dokter.dart';
import 'package:tubes/pages/buat_janji_temu/profil_lengkap_dokter.dart';
import 'package:tubes/pages/buat_janji_temu/pilih_jadwal.dart';
import 'package:tubes/pages/buat_janji_temu/periksa_janji_temu.dart';
import 'package:tubes/pages/buat_janji_temu/profil_pasien.dart';
import 'package:tubes/pages/dashboard/dashboard.dart';
import 'package:tubes/pages/login_forgot_reset/login.dart';
import 'package:tubes/pages/login_forgot_reset/lupa_kata_sandi.dart';
import 'package:tubes/pages/login_forgot_reset/cek_email.dart';
import 'package:tubes/pages/login_forgot_reset/kata_sandi_baru.dart';
import 'package:tubes/pages/login_forgot_reset/reset_success.dart';
import 'package:tubes/pages/lihat_janji_temu/histori_janji_temu.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya2.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';
import 'package:tubes/pages/rekam_medis/rekam_medis.dart';
import 'package:tubes/pages/rekam_medis/detail_rm.dart';
import 'package:tubes/pages/onboarding/onboard1.dart';
import 'package:tubes/pages/onboarding/onboard2.dart';
import 'package:tubes/pages/onboarding/onboard3.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';

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
          case '/dashboard':
            return 'Dashboard';
          // Add more cases for other routes
          default:
            return 'Cari & Buat Reservasi';
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/onboard2',
      routes: {
        '/': (context) => const Login(title: 'Login'),
        '/lupa_kata_sandi': (context) =>
            const LupaKataSandi(title: 'Lupa Kata Sandi'),
        '/cek_email': (context) => const CekEmail(title: 'Cek Email'),
        '/kata_sandi_baru': (context) =>
            const KataSandiBaru(title: 'Kata Sandi Baru'),
        '/reset_success': (context) =>
            const ResetSuccess(title: 'Reset Success'),
        '/cari_reservasi': (context) =>
            const CariReservasi(title: 'Cari & Buat Reservasi'),
        '/cari_dokter': (context) => const CariDokter(title: 'Cari Dokter'),
        '/profil_dokter': (context) =>
            const ProfilDokter(title: 'Profil Dokter'),
        '/profil_lengkap_dokter': (context) =>
            const ProfilLengkapDokter(title: 'Profil Lengkap Dokter'),
        '/pilih_jadwal': (context) => const PilihJadwal(title: 'Pilih Jadwal'),
        '/profil_pasien': (context) =>
            const ProfilPasien(title: 'Profil Pasien'),
        '/periksa_janji_temu': (context) =>
            const PeriksaJanjiTemu(title: 'Periksa Janji Temu'),
        '/dashboard': (context) => const Dashboard(title: 'Dashboard'),
        '/histori_janji': (context) =>
            const HistoriJanjiTemu(title: 'Histori Janji Temu'),
        '/rincian_janji': (context) =>
            const RincianJanjiTemu(title: 'Rincian Janji Temu'),
        '/janji_temu_saya2': (context) =>
            const JanjiTemuSaya2(title: 'Janji Temu Saya 2'),
        '/buat_akun': (context) => const BuatAkun(),
        '/data_diri': (context) => const DataDiri(),
        '/konfirm_email': (context) => const KonfirmasiEmail(),
        '/konfirm_telp': (context) => const KonfirmasiTelp(),
        '/no_telp': (context) => const NoTelp(),
        '/welcome_page': (context) => const SelamatDatang(),
        '/informasi_rumah_sakit': (context) => const InformasiRumahSakit(
              title: "Informasi Rumah Sakit",
            ),
        '/spesialisasi': (context) => const Spesialisasi(),
        '/detail_spesialisasi': (context) => const DetailSpesialisasi(),
        '/rekam_medis': (context) => const RekamMedis(),
        '/detail_rm': (context) => const DetailRekamMedis(),
        '/onboard1': (context) => const OnBoarding1(),
        '/onboard2': (context) => const OnBoarding2(),
        '/onboard3': (context) => const Onboarding3(),
        '/registrasi_pasien': (context) => const RegistrationScreen(),

        // Add more routes here
      },
    );
  }
}
