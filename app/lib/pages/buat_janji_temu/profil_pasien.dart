import 'package:flutter/material.dart';

class ProfilPasien extends StatefulWidget {
  const ProfilPasien({super.key, required this.title});

  final String title;

  @override
  State<ProfilPasien> createState() => _ProfilPasienState();
}

class _ProfilPasienState extends State<ProfilPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Pasien',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          const Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SAYA SENDIRI",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                const CustomContainer(
                  icon: Icons.filter_alt,
                  nama: "John Hendrick",
                  birthday: "7 Maret 2001",
                  email: "johnhendrick@gmail.com",
                  noHP: "08123456789",
                ),
                const SizedBox(height: 20),
                const Text(
                  "ORANG LAIN",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 90),
                const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.groups,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Anda belum menambahkan profil untuk orang lain",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/periksa_janji_temu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      40,
                    ),
                  ),
                  child: const Text('Selanjutnya',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final IconData icon;
  final String nama;
  final String birthday;
  final String email;
  final String noHP;

  const CustomContainer({
    super.key,
    required this.icon,
    required this.nama,
    required this.birthday,
    required this.email,
    required this.noHP,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isToggled = !_isToggled;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isToggled ? Colors.blue : Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.nama,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.birthday,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.noHP,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
