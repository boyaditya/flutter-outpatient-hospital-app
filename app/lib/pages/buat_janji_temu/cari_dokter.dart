import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/doctor_cubit.dart';
import 'package:tubes/cubits/doctor_schedule_cubit.dart';
import 'package:tubes/cubits/specialization_cubit.dart';
import 'package:tubes/pages/buat_janji_temu/profil_dokter.dart';

class CariDokter extends StatefulWidget {
  const CariDokter({super.key});

  @override
  State<CariDokter> createState() => _CariDokterState();
}

class _CariDokterState extends State<CariDokter> {
  final TextEditingController _controller = TextEditingController();
  String _selectedDay = 'Senin'; // default to Monday
  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  @override
  void initState() {
    super.initState();
    context.read<DoctorListCubit>().fetchDoctors();
    context.read<DoctorScheduleCubit>().fetchDoctorSchedule();
    context.read<SpecializationListCubit>().fetchSpecializations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Dokter',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView(
        children: [
          Container(
            height: 1, // Garis batas
            color: Colors.grey[300],
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
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {});
                    },
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
                Row(
                  children: [
                    CustomButton(
                        icon: Icons.filter_alt,
                        text: "Filter",
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _days.map((day) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(day),
                                selected: _selectedDay == day,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedDay = day;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Dokter',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 20),
                BlocBuilder<SpecializationListCubit, List<SpecializationModel>>(
                  builder: (context, specializations) {
                    final searchQuery = _controller.text.toLowerCase();
                    final matchingSpecializations = specializations
                        .where((spec) => spec.title.toLowerCase().contains(searchQuery))
                        .toList();

                    return BlocBuilder<DoctorScheduleCubit, List<DoctorScheduleModel>>(
                      builder: (context, schedules) {
                        final filteredSchedules = schedules
                            .where((schedule) => schedule.day == _selectedDay)
                            .toList();
                        final doctorIds = filteredSchedules
                            .map((schedule) => schedule.doctorId)
                            .toSet();

                        return BlocBuilder<DoctorListCubit, List<DoctorModel>>(
                          builder: (context, doctors) {
                            final filteredDoctors = doctors.where((doctor) {
                              final isNameMatch = doctor.name.toLowerCase().contains(searchQuery);
                              final isSpecializationMatch = matchingSpecializations
                                  .any((spec) => spec.id == doctor.idSpecialization);
                              return doctorIds.contains(doctor.id) && (isNameMatch || isSpecializationMatch);
                            }).toList();

                            return Column(
                              children: filteredDoctors.map((doctor) {
                                final specialization = specializations.firstWhere(
                                  (spec) => spec.id == doctor.idSpecialization,
                                  orElse: () => SpecializationModel(id: -1, title: 'Unknown', description: '', imgName: ''),
                                );
                                final specializationTitle = specialization.title;
                                return DoctorButton(
                                  icon: Icons.person,
                                  dokter: doctor.name,
                                  spesialis: specializationTitle,
                                  availability: 'Available',
                                  imagePath: doctor.imgPath,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilDokter(
                                            doctorId: doctor.id,
                                            specialization: specializationTitle),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                    );
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
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8), child: Icon(icon, size: 20)),
            Text(text,
                style: const TextStyle(fontSize: 11, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class DoctorButton extends StatelessWidget {
  final IconData icon;
  final String dokter;
  final String spesialis;
  final String availability;
  final String imagePath;
  final VoidCallback onPressed;

  const DoctorButton({
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
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
        padding: const EdgeInsets.all(6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: Colors.grey, width: 0.3),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
                radius: 40, backgroundImage: NetworkImage(imagePath)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dokter,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(spesialis,
                    style: const TextStyle(fontSize: 11, color: Colors.black),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 20),
                    const SizedBox(width: 4),
                    Text(availability,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.black),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}