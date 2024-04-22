import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BerikanPenilaianScreen extends StatefulWidget {
  @override
  _BerikanPenilaianScreenState createState() => _BerikanPenilaianScreenState();
}

class _BerikanPenilaianScreenState extends State<BerikanPenilaianScreen> {
  double _rating = 0;
  TextEditingController _commentController = TextEditingController();
  String _selectedCategory = 'Aplikasi Seluler';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berikan Penilaian', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Bagaimana pengalaman kunjungan anda di Athena Hospitals?',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
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
                Divider(
                  color: Colors.blue,  // Warna garis divider
                  thickness: 2.0,       // Ketebalan garis divider
                ),
                SizedBox(height: 25.0),
                Text(
                  'Mohon berikan komentar untuk peningkatan layanan kami',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold, // Teks menjadi tebal
                  ),
                ),
                SizedBox(height: 25.0),
                TextField(
                  controller: _commentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Ketikkan Komentar Anda di sini',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Kategori Penilaian:'),
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
                    // Tambahkan logika untuk mengirim data registrasi
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('KIRIM'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
