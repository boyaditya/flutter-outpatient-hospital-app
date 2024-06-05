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
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios_outlined),
          //   onPressed: () {},
          // ),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Spesialisasi',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: 'Cari Spesialisasi',
                  hintStyle: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SpecializationListCubit, List<SpecializationModel>>(
              builder: (context, specializations) {
                if (specializations.length <= 1 &&
                    specializations.first.id == 0) {
                  BlocProvider.of<SpecializationListCubit>(context)
                      .fetchSpecializations(); // trigger the event to fetch data
                  return const CircularProgressIndicator(); // show loading spinner while waiting for data
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: specializations.map((item) {
                      return CustomButton(
                        icon: Icons.remove_red_eye,
                        text: item.title,
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
                    }).toList(),
                  );
                }
              },
            )
          ],
        ),
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
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 227, 255),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
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
