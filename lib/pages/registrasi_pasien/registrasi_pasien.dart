import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi Pasien Baru',
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Tambahkan logika untuk kembali ke halaman sebelumnya
          },
        ),
        title: Text('Registrasi Pasien Baru'),
      ),
      body: SingleChildScrollView (
        child: Padding(
        padding: const EdgeInsets.all(16.0),
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harap isi data Anda yang sebenarnya.'),
              SizedBox(height: 16.0),
              Text('Nama Lengkap'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: '  Masukkan Nama Lengkap Anda',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Tanggal Lahir'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      hintText: '  DD/MM/YY',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Nomor Telepon'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: '  +62000000000000',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Alamat Email'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: '  test@email.com',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Nomor Induk Kependudukan'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: '  XXXXXXXXXXXXXXX',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
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
                  Expanded(
                    child: Text(
                      'Dengan ini saya menyatakan bahwa data yang saya berikan adalah benar dan saya menyetujui semua syarat dan ketentuan yang berlaku.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengirim data registrasi
                    },style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Kirim'),
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