import 'package:flutter/material.dart';
import 'package:tubes/pages/authentication/konfirm_telp.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  bool _agreeTerms = false;
  String? _gender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _dobController.text = picked.day.toString().padLeft(2, '0') +
            '/' +
            picked.month.toString().padLeft(2, '0') +
            '/' +
            picked.year.toString().substring(2);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Pasien Baru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Harap isi data Anda yang sebenarnya.'),
              const SizedBox(height: 16.0),
              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Nama Lengkap Anda',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Nomor Induk Kependudukan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '3234XXXXXXXXXXXXX',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Nomor Telepon',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '+6285123456789',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Jenis Kelamin'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    value: _gender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                    items: <String>['Laki-laki', 'Perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      hintText: 'Pilih salah satu',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Tanggal Lahir'),
              ElevatedButton(
								onPressed: () => _selectDate(context),
								style: ElevatedButton.styleFrom(
									padding: EdgeInsets.zero,
									backgroundColor: Colors.white,
									shadowColor: Colors.transparent,
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(5.0), // Match the border radius
									),
								),
								child: AbsorbPointer(
									child: Container(
										width: double.infinity, // Ensure the button takes the full width
										decoration: BoxDecoration(
											border: Border.all(color: Colors.grey),
											borderRadius: BorderRadius.circular(5.0),
										),
										child: Padding(
											padding: const EdgeInsets.all(8.0),
											child: TextFormField(
												controller: _dobController,
												decoration: const InputDecoration(
													hintText: '  DD/MM/YY',
													border: InputBorder.none,
												),
											),
										),
									),
								),
							),
              const SizedBox(height: 50.0),
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Dengan ini saya menyatakan bahwa data yang saya berikan adalah benar dan saya menyetujui semua syarat dan ketentuan yang berlaku.',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KonfirmasiTelp(),
                              ),
                            );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Kirim'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

