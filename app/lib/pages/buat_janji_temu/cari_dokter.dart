import 'package:flutter/material.dart';

class CariDokter extends StatefulWidget {
  const CariDokter({super.key, required this.title});

  final String title;

  @override
  State<CariDokter> createState() => _CariDokterState();
}

class _CariDokterState extends State<CariDokter> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> data =
        (ModalRoute.of(context)?.settings.arguments as Map<String, String>?) ??
            {};
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Cari Dokter',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
      body: ListView(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    initialValue: data['namaDokter'],
                    decoration: const InputDecoration(
                      hintText: 'Cari nama dokter atau spesialisasi',
                      hintStyle: TextStyle(fontSize: 13),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    icon: Icons.filter_alt, text: "Filter", onPressed: () {}),
                const SizedBox(height: 20),
                const Text(
                  'Dokter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton2(
                  icon: Icons.filter_alt,
                  dokter: "dr. John Doe, MARS, SpAk",
                  spesialis: "Andrologi - Spesialis Andrologi",
                  availability: "Tersedia hari ini",
                  imagePath: 'assets/images/dokter/dummy-doctor.jpg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/profil_dokter');
                  },
                ),
                const SizedBox(height: 10),
                CustomButton2(
                  icon: Icons.filter_alt,
                  dokter: "dr. John Doe, MARS, SpAk",
                  spesialis: "Andrologi - Spesialis Andrologi",
                  availability: "Tersedia hari ini",
                  imagePath: 'assets/images/dokter/dummy-doctor.jpg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/profil_dokter');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final IconData icon;
  final String dokter;
  final String spesialis;
  final String availability;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomButton2({
    super.key,
    required this.icon,
    required this.dokter,
    required this.spesialis,
    required this.availability,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(
            0.12), // This changes the color when the button is pressed
        padding: const EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(color: Colors.grey, width: 0.3),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dokter,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                spesialis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    availability,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
