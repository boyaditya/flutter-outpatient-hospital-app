// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// import 'lupa_kata_sandi.dart';
// import 'cek_email.dart';
// import 'kata_sandi_baru.dart';
// import 'reset_success.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateTitle: (BuildContext context) {
//         final routeName = ModalRoute.of(context)?.settings.name;

//         switch (routeName) {
//           case '/':
//             return 'Login';
//           // Add more cases for other routes
//           default:
//             return 'Login';
//         }
//       },
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const Login(title: 'Login'),
//         '/lupa_kata_sandi': (context) => const LupaKataSandi(title: 'Lupa Kata Sandi'),
//         '/cek_email': (context) => const CekEmail(title: 'Cek Email'),
//         '/kata_sandi_baru': (context) => const KataSandiBaru(title: 'Kata Sandi Baru'),
//         '/reset_success': (context) => const ResetSuccess(title: 'Reset Success'),

//         // Add more routes here
//       },
//     );
//   }
// }

class Login extends StatefulWidget {
  const Login({super.key, required String title});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        isButtonEnabled = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      setState(() {
        isButtonEnabled = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      });
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 150,
                height: 150,
              ),
            ),
            const Center(
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Alamat Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Alamat Email',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Kata Sandi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kata Sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.pushNamed(context, '/dashboard');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child:
                    const Text('Masuk', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/lupa_kata_sandi');
                },
                child: const Text('Lupa Kata Sandi?',
                    style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum punya akun?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/buat_akun');
                  },
                  child: const Text('Daftar Sekarang',
                      style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
