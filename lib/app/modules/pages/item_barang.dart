// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plmobile/app/data/item_barang.dart';
import 'package:plmobile/app/modules/pages/item_barang_body.dart';
import 'package:plmobile/app/modules/pages/log_in_page.dart';

class Barang extends StatefulWidget {
  const Barang({super.key});

  @override
  State<Barang> createState() => BarangState();
}

class BarangState extends State<Barang> {
  final formState = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isDataEntered = false;
  bool isDataEntered2 = false;

  final idItemController = TextEditingController();
  final nameItemController = TextEditingController();
  final descriptionController = TextEditingController();
  final weightController = TextEditingController();
  final totalController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: const Text('Barang', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 193, 186),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BarangBody()),
                  (route) => true);
            },
            icon: const Icon(
              Icons.article_outlined,
              color: Colors.white,
              size: 30,
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
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formState,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: TextFormField(
                      controller: idItemController,
                      validator: (id) {
                        if (id == '') {
                          return 'Kode barang tidak boleh kosong';
                        } else if (id!.length > 6) {
                          return 'Kode barang maksimal 6 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Kode Barang',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.unarchive_outlined),
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
                      controller: nameItemController,
                      validator: (name) {
                        if (name == '') {
                          return 'Nama barang tidak boleh kosong';
                        } else if (name!.length > 12) {
                          return 'Nama barang maksimal 12 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Nama Barang',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.category),
                          border: OutlineInputBorder()),
                      onChanged: (String name) {
                        getName(name);
                        setState(() {
                          isDataEntered = name.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: descriptionController,
                      validator: (description) {
                        if (description == '') {
                          return 'Deskripsi tidak boleh kosong';
                        } else if (description!.length > 20) {
                          return 'Deskripsi maksimal 20 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder()),
                      onChanged: (String description) {
                        getDescription(description);
                        setState(() {
                          isDataEntered = description.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: weightController,
                      validator: (weightItem) {
                        if (weightItem == '') {
                          return 'Berat barang tidak boleh kosong';
                        } else if (weightItem!.length > 12) {
                          return 'Berat barang maksimal 12 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Berat',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.line_weight),
                          border: OutlineInputBorder()),
                      onChanged: (String weightItem) {
                        getWeightItem(weightItem);
                        setState(() {
                          isDataEntered = weightItem.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: totalController,
                      validator: (total) {
                        if (total == '') {
                          return 'Jumlah barang tidak boleh kosong';
                        } else if (total!.length > 12) {
                          return 'Jumlah barang maksimal 12 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Pcs',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.production_quantity_limits),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String total) {
                        getTotalItem(total);
                        setState(() {
                          isDataEntered = total.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: priceController,
                      validator: (price) {
                        if (price == '') {
                          return 'Total harga tidak boleh kosong';
                        } else if (price!.length > 20) {
                          return 'Total harga maksimal 20 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Harga',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.price_change),
                          border: OutlineInputBorder()),
                      onChanged: (String price) {
                        getPriceItem(price);
                        setState(() {
                          isDataEntered = price.isNotEmpty;
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
    );
  }
}
