import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:tubes/pages/authentication/konfirm_telp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/cubits/patient_cubit.dart';
import 'package:tubes/utils/snackbar.dart';

class TambahProfilPasien extends StatefulWidget {
  const TambahProfilPasien({super.key});

  @override
  State<TambahProfilPasien> createState() => _TambahProfilPasienState();
}

class _TambahProfilPasienState extends State<TambahProfilPasien> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _agreeTerms = false;
  String? _gender;

  bool _isNameEntered = false;
  bool _isNikEntered = false;
  bool _isPhoneEntered = false;
  bool _isDobEntered = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
        _isDobEntered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Profil Pasien Baru'),
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
                onChanged: (value) {
                  setState(() {
                    _isNameEntered = value.isNotEmpty;
                  });
                },
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
                controller: _nikController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '3234XXXXXXXXXXXXX',
                ),
                onChanged: (value) {
                  setState(() {
                    _isNikEntered = value.isNotEmpty;
                  });
                },
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
                onChanged: (value) {
                  setState(() {
                    _isPhoneEntered = value.isNotEmpty;
                  });
                },
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
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
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
                    borderRadius:
                        BorderRadius.circular(5.0), // Match the border radius
                  ),
                ),
                child: AbsorbPointer(
                  child: Container(
                    width: double
                        .infinity, // Ensure the button takes the full width
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
                child: ElevatedButton(
                  onPressed: _isNameEntered &&
                          _isNikEntered &&
                          _isPhoneEntered &&
                          _isDobEntered &&
                          _agreeTerms
                      ? () {
                          performRegister();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isNameEntered &&
                            _isNikEntered &&
                            _isPhoneEntered &&
                            _isDobEntered &&
                            _agreeTerms
                        ? Colors.blue[700]
                        : Colors.grey, // Warna abu-abu jika input belum diisi
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      40,
                    ), // Lebar 50% dari lebar layar
                  ),
                  child: const Text(
                    'Tambah Profil Pasien',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    final patient = PatientModel(
      id: 0,
      userId: 0,
      name: _nameController.text,
      dateOfBirth: DateFormat('dd/MM/yyyy').parse(_dobController.text),
      phone: _phoneController.text,
      nik: _nikController.text,
      gender: _gender!,
    );

    try {
      await context.read<PatientListCubit>().postPatient(patient);
      if (!mounted) return;
      showSuccessMessage(context, 'Tambah profil pasien berhasil!');
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      // print(e);
      showErrorMessage(context, 'Tambah profil pasien gagal!');
      // Handle the error
    }
  }
}
