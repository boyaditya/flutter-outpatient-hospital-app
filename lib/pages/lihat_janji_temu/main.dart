import 'package:flutter/material.dart';
import 'package:tubes/pages/lihat_janji_temu/histori_janji_temu.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya1.dart';
import 'package:tubes/pages/lihat_janji_temu/janji_temu_saya2.dart';
import 'package:tubes/pages/lihat_janji_temu/rincian_janji_temu.dart';

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
            return 'Janji Temu Saya 2';
          case '/janji_temu_1':
            return 'Janji Temu Saya 1';
          case '/histori_janji':
            return 'Histori Janji Temu';
          case '/rincian_janji':
            return 'Rincian Janji Temu';
          // Add more cases for other routes
          default:
            return 'Janji Temu Saya 2';
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const JanjiTemuSaya2(title: 'Janji Temu Saya 2'),
        '/janji_temu_1': (context) =>
            const JanjiTemuSaya1(title: 'Janji Temu Saya 1'),
        '/histori_janji': (context) =>
            const HistoriJanjiTemu(title: 'Histori Janji Temu'),
        '/rincian_janji': (context) =>
            const RincianJanjiTemu(title: 'Rincian Janji Temu'),

        // Add more routes here
      },
    );
  }
}
