import 'package:flutter/material.dart';

class JanjiTemuSaya2 extends StatefulWidget {
  const JanjiTemuSaya2({super.key, required this.title});

  final String title;

  @override
  State<JanjiTemuSaya2> createState() => _JanjiTemuSaya2State();
}

class _JanjiTemuSaya2State extends State<JanjiTemuSaya2> {
  int _selectedTabIndex = 0; // Menyimpan indeks teks yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    height: 120,
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
                    child: Text(
                      "Janji Temu Saya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 56,
                    right: 20,
                    child: Container(
                      width:
                          400, // Add this line to set the width of the Container
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(96, 192, 227, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildText("Saya Sendiri", 0),
                            _buildText("Orang Lain", 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 60, // Atur posisi awal ke tepi kiri
                    right: 240, // Atur posisi akhir ke tepi kanan
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height:
                          _selectedTabIndex == 0 ? 4 : 0, // Set lebar awal ke 0

                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 240, // Atur posisi awal ke tepi kiri
                    right: 50, // Atur posisi akhir ke tepi kanan
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height:
                          _selectedTabIndex == 1 ? 4 : 0, // Set lebar awal ke 0

                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildIsian()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // Perbarui indeks yang dipilih
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: _selectedTabIndex == index
              ? Colors.white
              : const Color.fromARGB(255, 98, 97, 97),
        ),
      ),
    );
  }

  Widget _buildIsian() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Janji temu yang akan datang",
            style: TextStyle(fontSize: 17, color: Colors.blue),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),
          InkWell(
						onTap: () {
							Navigator.pushNamed(context, '/rincian_janji');
						},
						borderRadius: BorderRadius.circular(10),
						child: Ink(
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
							child: InkWell(
								borderRadius: BorderRadius.circular(10),
								child: Container(
									padding: const EdgeInsets.all(20),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											const Row(
												children: [
													Icon(
														Icons.person_4_outlined,
														color: Colors.grey,
													),
													SizedBox(width: 8),
													Text(
														'Rawat Jalan',
														style: TextStyle(
															fontWeight: FontWeight.bold,
															fontSize: 20,
															color: Colors.grey,
														),
													),
												],
											),
											const SizedBox(height: 10),
											const Text(
												"John Hendrick\n11 Mar 2024, 11:00-11.30\ndr. Alvin H Hardjawinata, MARS, SpAk",
												style: TextStyle(
													fontSize: 15,
													color: Colors.black,
													fontWeight: FontWeight.bold,
												),
												textAlign: TextAlign.left,
											),
											const Text(
												"Spesialis akupuntur",
												style: TextStyle(fontSize: 15, color: Colors.black),
												textAlign: TextAlign.left,
											),
											const SizedBox(height: 10),
											Container(
												width: 300,
												padding: const EdgeInsets.symmetric(
													vertical: 8,
													horizontal: 12,
												),
												decoration: BoxDecoration(
													color: Colors.yellow,
													borderRadius: BorderRadius.circular(8),
												),
												child: const Row(
													children: [
														Icon(
															Icons.info_outline,
															color: Colors.black,
														),
														SizedBox(width: 8),
														Text(
															'Silahkan menuju ke front office',
															style: TextStyle(
																fontSize: 15,
																color: Colors.black,
															),
														),
													],
												),
											),
										],
									),
								),
							),
						),
					),
          const SizedBox(height: 15),
          InkWell(
						onTap: () {
							Navigator.pushNamed(context, '/histori_janji');
						},
						borderRadius: BorderRadius.circular(8),
						child: Ink(
							padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
							decoration: BoxDecoration(
								color: Colors.white, // Ubah warna sesuai kebutuhan
								borderRadius: BorderRadius.circular(8),
							),
							child: Text(
								"LIHAT HISTORI JANJI TEMU",
								style: TextStyle(
									fontSize: 16,
									color: Colors.blue[900],
									fontWeight: FontWeight.bold,
									decoration: TextDecoration.underline,
								),
							),
						),
					),

        ],
      ),
    );
  }
}
