import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
class DetailSpesialisasi extends StatefulWidget {
  const DetailSpesialisasi({super.key, required this.specializationId});

  final int specializationId;

  @override
  State<DetailSpesialisasi> createState() => _DetailSpesialisasiState();
}

class _DetailSpesialisasiState extends State<DetailSpesialisasi> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecializationListCubit, List<SpecializationModel>>(
      builder: (context, specializations) {
        final specialization = specializations.firstWhere(
          (s) => s.id == widget.specializationId,
          orElse: () => SpecializationModel(
            id: 0,
            title: "",
            description: "",
            imgName: "",
          ),
        );

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(specialization.title),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: Colors.grey,
                height: 0.3,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Menambahkan margin kanan dan kiri
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(specialization.imgName),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        specialization.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Kondisi yang Kami Tangani',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                // BulletList(
                //   items: specialization.conditionsHandled,
                // ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Perawatan & Layanan yang Kami Sediakan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // BulletList(
                //   items: specialization.treatmentsProvided,
                // ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '*Harap diperhatikan bahwa ini bukanlah daftar lengkap semua kondisi dan perawatan yang kami sediakan. Informasi ini dimaksudkan sebagai panduan kasar dan bukan sebagai saran medis.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cari_dokter');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Cari Spesialis',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(item)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
