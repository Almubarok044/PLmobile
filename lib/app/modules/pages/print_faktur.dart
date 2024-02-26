import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plmobile/app/data/print_faktur.dart';
import 'package:plmobile/app/modules/pages/print_faktur_body.dart';
import 'package:plmobile/app/modules/pages/log_in_page.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  final idFakturController = TextEditingController();
  final dateController = TextEditingController();
  final typeOfPaymentController = TextEditingController();

  final idCustomerController = TextEditingController();
  final nameCustomerController = TextEditingController();
  final addressCustomerController = TextEditingController();
  final numberCustomerController = TextEditingController();

  final idItemController = TextEditingController();
  final nameItemController = TextEditingController();
  final weightController = TextEditingController();
  final totalController = TextEditingController();
  final priceController = TextEditingController();

  DateTime dateSelected = DateTime.now();
  Future<void> selectedDate() async {
    DateTime? picked = await showDatePicker(
        // DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: DateTime.now(),
        initialDate: dateSelected,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null && picked != dateSelected) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
        dateSelected = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: const Text('Faktur', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 193, 186),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrintPageBody()),
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
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formState,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: TextFormField(
                      controller: idFakturController,
                      validator: (id) {
                        if (id == '') {
                          return 'No. Faktur tidak boleh kosong';
                        } else if (id!.length > 6) {
                          return 'No. Faktur maksimal 6 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'No. Faktur',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.mark_as_unread_outlined),
                          border: OutlineInputBorder()),
                      onChanged: (String id) {
                        getIdFaktur(id);
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
                      controller: dateController,
                      validator: (picked) {
                        if (picked == '') {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Tanggal',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.date_range_sharp),
                          border: OutlineInputBorder()),
                      readOnly: true,
                      onTap: () {
                        selectedDate();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: typeOfPaymentController,
                      validator: (payment) {
                        if (payment == '') {
                          return 'Jenis pembayaran tidak boleh kosong';
                        } else if (payment!.length > 12) {
                          return 'Jenis pembayaran maksimal 12 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Jenis Pembayaran',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.wallet),
                          border: OutlineInputBorder()),
                      onChanged: (String payment) {
                        getTypeOfPayment(payment);
                        setState(() {
                          isDataEntered = payment.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: idCustomerController,
                      validator: (idCustomer) {
                        if (idCustomer == '') {
                          return 'Kode pelanggan tidak boleh kosong';
                        } else if (idCustomer!.length > 6) {
                          return 'Kode pelanggan maksimal 6 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Kode Pelanggan',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder()),
                      onChanged: (String idCustomer) {
                        getCustomerId(idCustomer);
                        setState(() {
                          isDataEntered = idCustomer.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: nameCustomerController,
                      validator: (nameCustomer) {
                        if (nameCustomer == '') {
                          return 'Nama pelanggan tidak boleh kosong';
                        } else if (nameCustomer!.length > 20) {
                          return 'Nama pelanggan maksimal 20 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nama Pelanggan',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String nameCustomer) {
                        getCustomerName(nameCustomer);
                        setState(() {
                          isDataEntered = nameCustomer.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: addressCustomerController,
                      validator: (addressCustomer) {
                        if (addressCustomer == '') {
                          return 'Alamat tidak boleh kosong';
                        } else if (addressCustomer!.length > 20) {
                          return 'Alamat maksimal 20 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Alamat',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.place),
                          border: OutlineInputBorder()),
                      onChanged: (String addressCustomer) {
                        getCustomerAddress(addressCustomer);
                        setState(() {
                          isDataEntered = addressCustomer.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: numberCustomerController,
                      validator: (numberCustomer) {
                        if (numberCustomer == '') {
                          return 'No. Telp tidak boleh kosong';
                        } else if (!RegExp(r'^[0-9]+$')
                            .hasMatch(numberCustomer!)) {
                          return 'No. Telp hanya boleh diisi dengan angka';
                        } else if (numberCustomer.length > 12) {
                          return 'No. Telp maksimal 12 karakter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'No. Telp',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.phone_in_talk),
                          border: OutlineInputBorder()),
                      onChanged: (String numberCustomer) {
                        getNoHp(numberCustomer);
                        setState(() {
                          isDataEntered = numberCustomer.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: TextFormField(
                      controller: idItemController,
                      validator: (idItem) {
                        if (idItem == '') {
                          return 'Kode barang tidak boleh kosong';
                        } else if (idItem!.length > 6) {
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
                      onChanged: (String idItem) {
                        getIdItem(idItem);
                        setState(() {
                          isDataEntered = idItem.isNotEmpty;
                          isDataEntered2 = idItem.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: nameItemController,
                      validator: (nameItem) {
                        if (nameItem == '') {
                          return 'Nama Barang tidak boleh kosong';
                        } else if (nameItem!.length > 20) {
                          return 'Nama barang maksimal 20 karakter';
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
                      onChanged: (String nameItem) {
                        getNameItem(nameItem);
                        setState(() {
                          isDataEntered = nameItem.isNotEmpty;
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
                      validator: (totalItem) {
                        if (totalItem == '') {
                          return 'Jumlah barang tidak boleh kosong';
                        } else if (totalItem!.length > 12) {
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
                      onChanged: (String totalItem) {
                        getTotalItem(totalItem);
                        setState(() {
                          isDataEntered = totalItem.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: priceController,
                      validator: (priceItem) {
                        if (priceItem == '') {
                          return 'Total harga tidak boleh kosong';
                        } else if (priceItem!.length > 20) {
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
                      onChanged: (String priceItem) {
                        getPriceItem(priceItem);
                        setState(() {
                          isDataEntered = priceItem.isNotEmpty;
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
                      const SizedBox(width: 3),
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
                      const SizedBox(width: 3),
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
                      const SizedBox(width: 3),
                      FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        onPressed: () {
                          checkAndPDFData();
                        },
                        child: const Icon(Icons.picture_as_pdf),
                      ),
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
