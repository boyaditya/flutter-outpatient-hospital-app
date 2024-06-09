import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tubes/cubits/rating_cubit.dart';

class BerikanPenilaianScreen extends StatefulWidget {
  const BerikanPenilaianScreen({super.key});

  @override
  State<BerikanPenilaianScreen> createState() => _BerikanPenilaianScreenState();
}

class _BerikanPenilaianScreenState extends State<BerikanPenilaianScreen> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  String _selectedCategory = 'Aplikasi Seluler';

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berikan Penilaian',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Bagaimana pengalaman kunjungan anda di Athena Hospitals?',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue, // Warna garis divider
                  thickness: 2.0, // Ketebalan garis divider
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'Mohon berikan komentar untuk peningkatan layanan kami',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold, // Teks menjadi tebal
                  ),
                ),
                const SizedBox(height: 25.0),
                TextField(
                  controller: _commentController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Ketikkan Komentar Anda di sini',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('Kategori Penilaian:'),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: [
                    'Aplikasi Seluler',
                    'Pelayanan Rumah Sakit',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    performAddRating(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('KIRIM'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performAddRating(BuildContext context) async {
    try {
      final rating = RatingModel(
          id: 0,
          userId: 0,
          rating: _rating,
          comment: _commentController.text,
          category: _selectedCategory);

      await context.read<RatingCubit>().addRating(rating);
      showSuccessMessage('Penilaian berhasil dikirim');
      Navigator.pop(context);
    } catch (e) {
      print(e);
      showErrorMessage('Gagal mengirim penilaian');
      // Handle the error
    }
  }
}
