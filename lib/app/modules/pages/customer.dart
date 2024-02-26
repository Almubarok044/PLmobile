// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plmobile/app/data/customer.dart';
import 'package:plmobile/app/modules/pages/customer_body.dart';
import 'package:plmobile/app/modules/pages/log_in_page.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: const Text('Customer', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 193, 186),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerBody(children: [])),
                  (route) => true);
            },
            icon: const Icon(
              Icons.article_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 112, 193, 186),
          child: DrawerHeader(
              child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset('assets/icon/logo_pt_rpg.png',
                    height: 105, width: 105),
                const Text(
                  'PT. RICKY PUTRA GLOBALINDO',
                  style: TextStyle(
                      color: Color(0xff2C306F),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1, color: Colors.white),
                ListTile(
                    selectedColor: Colors.white,
                    tileColor: Colors.white,
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: const Icon(Icons.exit_to_app, color: Colors.white),
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInPage()),
                            (route) => false);
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  content: Text('Logout success'),
                                ));
                      } on FirebaseAuthException catch (e) {
                        if (kDebugMode) {
                          if (kDebugMode) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(e.message.toString()),
                                  ));
                        }
                      }
                    }),
              ],
            ),
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom * 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formState,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: TextFormField(
                        controller: idController,
                        validator: (id) {
                          if (id == '') {
                            return 'Kode pelanggan tidak boleh kosong';
                          } else if (id!.length > 6) {
                            return 'Kode pelanggan maksimal 6 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'Kode Pelanggan',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.badge),
                            border: OutlineInputBorder()),
                        onChanged: (String id) {
                          getId(id);
                          setState(() {
                            isDataEntered = id.isNotEmpty;
                            isDataEntered2 = id.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: nameController,
                        validator: (name) {
                          if (name == '') {
                            return 'Nama pelanggan tidak boleh kosong';
                          } else if (name!.length > 20) {
                            return 'Nama pelanggan maksimal 20 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'Nama Pelanggan',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder()),
                        onChanged: (String name) {
                          getCustomerName(name);
                          setState(() {
                            isDataEntered = name.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: addressController,
                        validator: (address) {
                          if (address == '') {
                            return 'Alamat tidak boleh kosong';
                          } else if (address!.length > 20) {
                            return 'Alamat maksimal 20 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'Alamat',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.place),
                            border: OutlineInputBorder()),
                        onChanged: (String address) {
                          getAddress(address);
                          setState(() {
                            isDataEntered = address.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: cityController,
                        validator: (city) {
                          if (city == '') {
                            return 'Kota tidak boleh kosong';
                          } else if (city!.length > 12) {
                            return 'Nama kota maksimal 12 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Kota',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String city) {
                          getCity(city);
                          setState(() {
                            isDataEntered = city.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: emailController,
                        validator: validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder()),
                        onChanged: (String email) {
                          getEmail(email);
                          setState(() {
                            isDataEntered = email.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: numberController,
                        validator: (number) {
                          if (number == '') {
                            return 'No. Telp tidak boleh kosong';
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(number!)) {
                            return 'No. Telp hanya boleh diisi dengan angka';
                          } else if (number.length > 12) {
                            return 'No. Telp maksimal 12 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'No. Telp',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.phone_in_talk),
                            border: OutlineInputBorder()),
                        onChanged: (String number) {
                          getNoHp(number);
                          setState(() {
                            isDataEntered = number.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              checkAndAddData();
                            } else {}
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                // <-- Icon
                                Icons.save,
                                size: 20,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Save',
                                style: TextStyle(color: Colors.lightBlue),
                              ), // <-- Text
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              checkAndUpdateData();
                            } else {}
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                // <-- Icon
                                Icons.edit,
                                size: 20,
                                color: Colors.orangeAccent,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.orangeAccent),
                              ), // <-- Text
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: (isDataEntered && isDataEntered2)
                              ? () {
                                  // Lakukan perintah jika data telah dimasukkan
                                  checkAndDeleteData();
                                }
                              : null, // Biarkan null jika tidak ada data yang dimasukan
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                // <-- Icon
                                Icons.delete,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ), // <-- Text
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
