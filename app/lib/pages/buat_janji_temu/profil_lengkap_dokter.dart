import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';

class ProfilLengkapDokter extends StatefulWidget {
  const ProfilLengkapDokter({super.key, required this.doctorId});

  final int doctorId;

  @override
  State<ProfilLengkapDokter> createState() => _ProfilDokterLengkapState();
}

class _ProfilDokterLengkapState extends State<ProfilLengkapDokter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, List<DoctorModel>>(
      builder: (context, state) {
        final doctor =
            context.read<DoctorListCubit>().getDoctorById(widget.doctorId);
        final specialization = context
            .read<SpecializationListCubit>()
            .getSpecializationById(doctor.idSpecialization);
        final specializationTitle = specialization.title;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profil Lengkap Dokter',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(90),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 70),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(doctor.imgPath),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        specializationTitle,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  InfoCard(
                    icon: Icons.medical_services,
                    title: 'Kondisi & Minat Klinis',
                    content: [doctor.interest],
                  ),
                  InfoCard(
                    icon: Icons.school,
                    title: 'Pendidikan',
                    content: [doctor.education],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> content;

  const InfoCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      margin: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...content.map((text) => Text(text)),
        ],
      ),
    );
  }
}
