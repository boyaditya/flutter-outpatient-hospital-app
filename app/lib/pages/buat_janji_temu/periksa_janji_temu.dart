import 'package:flutter/material.dart';

class PeriksaJanjiTemu extends StatefulWidget {
  const PeriksaJanjiTemu({super.key, required this.title});

  final String title;

  @override
  State<PeriksaJanjiTemu> createState() => _PeriksaJanjiTemuState();
}

class _PeriksaJanjiTemuState extends State<PeriksaJanjiTemu> {
  static const List<String> listSpesialisasi = <String>[
    'One',
    'Two',
    'Three',
    'Four'
  ];

  String spesialisasiValue = listSpesialisasi.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Periksa Janji Temu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
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
                Text(
                  "Silahkan periksa kembali detail janji temu untuk memastikan kesesuaian informasi sebelum Anda melakukan konfirmasi",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI PASIEN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[50],
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InfoItem(
                        label: "NAMA LENGKAP",
                        value: "John Doe",
                      ),
                      InfoItem(
                        label: "TANGGAL LAHIR",
                        value: "12 Januari 1990",
                      ),
                      InfoItem(
                        label: "EMAIL",
                        value: "johnhendrick@gmail.com",
                      ),
                      InfoItem(
                        label: "NOMOR PNSEL",
                        value: "081234567890",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI JANJI TEMU",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[50],
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InfoItem(
                        label: "TANGGAL DAN WAKTU JANJI TEMU",
                        value: "24 April 2024, 14:00 - 16:30",
                      ),
                      InfoItem(
                        label: "DOKTER",
                        value: "dr. John Doe",
                      ),
                      InfoItem(
                        label: "SPESIALIS",
                        value: "Spesialis Akupuntur",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "INFORMASI PENJAMIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomDropdownMenu(
                    list: listSpesialisasi,
                    initialSelection: spesialisasiValue),
                const SizedBox(height: 120),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rincian_janji');
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
                  child: const Text('Konfirmasi',
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

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  final List<String> list;
  final String initialSelection;

  const CustomDropdownMenu({
    super.key,
    required this.list,
    required this.initialSelection,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: DropdownMenu<String>(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width - 40,
        initialSelection: widget.initialSelection,
        menuHeight: 200,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
