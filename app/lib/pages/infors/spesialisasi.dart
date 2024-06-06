import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/infors/detail_spesialisasi.dart';

class Spesialisasi extends StatelessWidget {
  const Spesialisasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spesialisasi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 1,
              color: Colors.grey, // Warna garis pemisah
            ),
            const SizedBox(height: 50),
            BlocBuilder<SpecializationListCubit, List<SpecializationModel>>(
              builder: (context, specializations) {
                if (specializations.length <= 1 &&
                    specializations.first.id == 0) {
                  BlocProvider.of<SpecializationListCubit>(context)
                      .fetchSpecializations(); // trigger the event to fetch data
                  return const CircularProgressIndicator(); // show loading spinner while waiting for data
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: specializations.length,
                      itemBuilder: (context, index) {
                        final item = specializations[index];
                        return CustomButton(
                          imagePath: 'assets/images/akupuntur.png', // Gunakan imagePath dari model
                          text: item.title,
                          subText: 'Lihat info detail spesialisasi', // Hardcoded subtext
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSpesialisasi(
                                  specializationId: item.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final String subText;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.subText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4), // Jarak antara teks utama dan subteks
                  Text(
                    subText,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
