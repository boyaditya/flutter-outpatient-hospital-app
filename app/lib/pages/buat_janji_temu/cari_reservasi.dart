import 'package:flutter/material.dart';

class CariReservasi extends StatefulWidget {
  const CariReservasi({super.key, required this.title});

  final String title;

  @override
  State<CariReservasi> createState() => _CariReservasiState();
}

class _CariReservasiState extends State<CariReservasi> {
  static const List<String> listSpesialisasi = <String>[
    'One',
    'Two',
    'Three',
    'Four'
  ];

  static const List<String> listHari = <String>[
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  final namaDokterController = TextEditingController();
  final spesialisasiController = TextEditingController();
  final hariController = TextEditingController();

  String spesialisasiValue = listSpesialisasi.first;
  String hariValue = listHari.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(230, 30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cari & Buat Reservasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Cari dokter atau spesialisasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cari nama dokter atau spesialisasi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: namaDokterController,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan nama dokter atau spesialisasi',
                          hintStyle: TextStyle(fontSize: 14),
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
                    const Text(
                      'Spesialisasi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    CustomDropdownMenu(
                      list: listSpesialisasi,
                      initialSelection: spesialisasiValue,
                      controller: spesialisasiController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Hari',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    CustomDropdownMenu(
                      list: listHari,
                      initialSelection: hariValue,
                    ),
                    const SizedBox(height: 90),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/cari_dokter',
                          arguments: {
                            'namaDokter': namaDokterController.text,
                            'spesialisasi': spesialisasiController.text,
                            'hari': hariController.text,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          40,
                        ), // 50% of screen width
                      ),
                      child: const Text('Cari',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  final List<String> list;
  final String initialSelection;
  final TextEditingController? controller;

  const CustomDropdownMenu({
    super.key,
    required this.list,
    required this.initialSelection,
    this.controller,
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
