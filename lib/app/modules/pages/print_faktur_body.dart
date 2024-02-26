import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plmobile/app/data/print_faktur.dart';

class PrintPageBody extends StatefulWidget {
  const PrintPageBody({super.key});

  @override
  State<PrintPageBody> createState() => _PrintPageBodyState();
}

class _PrintPageBodyState extends State<PrintPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          title:
              const Text('List Faktur', style: TextStyle(color: Colors.white)),
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 112, 193, 186),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('faktur')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot<Map<String, dynamic>>?
                                  documentSnapshot = snapshot.data!.docs[index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.brown[200]),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                height: 395,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text('No. Faktur : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['fakturId']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Tanggal : '),
                                        Expanded(
                                          child: Text(DateFormat('yyyy-MM-dd')
                                              .format(dateSelected)),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Jenis Pembayaran : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['typeOfPayment']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Kode Pelanggan : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerId']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Nama Pelanggan : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerName']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Alamat : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerAddress']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('No. Telp : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerNumberHP']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Kode Barang : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemIdFaktur']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Nama Barang : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemNameFaktur']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Berat : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemWeightFaktur']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Jumlah Pcs : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemTotalFaktur']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Harga : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemPriceFaktur']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ])),
        ));
  }
}
