import 'package:flutter/material.dart';

// void main() => runApp(const MaterialApp(
//   home: ForgetPass(),
// ));

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  late DateTime _selectedDate;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? _selectedGender;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateController.text.isEmpty;
    _nameController.addListener(_checkFormCompletion);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _selectedDate.day.toString().padLeft(2, '0') +
            '/' +
            _selectedDate.month.toString().padLeft(2, '0') +
            '/' +
            _selectedDate.year.toString();
        _checkFormCompletion();
      });
    }
  }

  void _checkFormCompletion() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _selectedGender != null &&
          _dateController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Beritahu kami tentang diri Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Harap  masukkan nama Anda sesuai dengan yang tertera pada dokumen resmi dan kartu identitas Anda.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Nama Lengkap'),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama lengkap',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Jenis Kelamin',
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih salah satu',
              ),
              items: <String>['Laki-laki', 'Perempuan']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                  _checkFormCompletion();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Tanggal Lahir',
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'DD/MM/YYYY',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                fixedSize: Size(MediaQuery.of(context).size.width,
                    40), // 50% of screen width
              ),
              onPressed: _isButtonEnabled ? () {
                Navigator.pushNamed(context, '/konfirm_email');
              } : null,
              child: const Text('Selanjutnya', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
