import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/doctor_schedule_cubit.dart';
import 'package:tubes/cubits/medical_record_cubit.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/cubits/rating_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/cubits/appointment_cubit.dart';
import 'package:tubes/pages/authentication/buat_akun.dart';
import 'package:tubes/pages/authentication/data_diri.dart';
import 'package:tubes/pages/authentication/konfirm_email.dart';
import 'package:tubes/pages/authentication/konfirm_telp.dart';
import 'package:tubes/pages/authentication/no_telp.dart';
import 'package:tubes/pages/authentication/welcome_page.dart';
import 'package:tubes/pages/infors/infors.dart';
import 'package:tubes/pages/infors/spesialisasi.dart';
import 'package:tubes/pages/buat_janji_temu/cari_dokter.dart';
import 'package:tubes/pages/registrasi_pasien/registrasi_pasien.dart';
import 'package:tubes/pages/rekam_medis/rekam_medis.dart';
import 'package:tubes/pages/onboarding/onboard1.dart';
import 'package:tubes/pages/onboarding/onboard2.dart';
import 'package:tubes/cubits/user_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ar', '').then((value) => null);
  initializeDateFormatting('en', '').then((value) => null);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<DoctorListCubit>(
      create: (context) => DoctorListCubit()..fetchDoctors(),
    ),
    BlocProvider<SpecializationListCubit>(
      create: (context) => SpecializationListCubit()..fetchSpecializations(),
    ),
    BlocProvider<UserCubit>(
      create: (context) => UserCubit(),
    ),
    BlocProvider<DoctorScheduleCubit>(
      create: (context) => DoctorScheduleCubit(),
    ),
    BlocProvider<PatientListCubit>(
      create: (context) => PatientListCubit(),
    ),
    BlocProvider<PatientListCubit>(
      create: (context) => PatientListCubit(),
    ),
    BlocProvider<AppointmentCubit>(
      create: (context) => AppointmentCubit(),
    ),
    BlocProvider<MedicalRecordCubit>(
      create: (context) => MedicalRecordCubit(),
    ),
    BlocProvider<RatingCubit>(
      create: (context) => RatingCubit(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Atur font default menggunakan GoogleFonts
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding2(),
        '/cari_dokter': (context) => const CariDokter(),
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
        '/rekam_medis': (context) => const RekamMedis(),
        '/onboard1': (context) => const OnBoarding1(),
        '/onboard2': (context) => const OnBoarding2(),
        '/registrasi_pasien': (context) => const RegistrationScreen(),
      },
    );
  }
}
