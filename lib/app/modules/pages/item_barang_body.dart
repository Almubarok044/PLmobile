// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarangBody extends StatelessWidget {
  const BarangBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          title:
              const Text('List Barang', style: TextStyle(color: Colors.white)),
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
                        .collection('itembarang')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot<Map<String, dynamic>>?
                                  documentSnapshot = snapshot.data!.docs[index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.lime[400]),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                height: 200,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Kode Barang : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemId']
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
                                              .data()['itemName']
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
                                        const Text('Deskripsi : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['itemDescription']
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
                                              .data()['itemWeight']
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
                                              .data()['itemTotal']
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
                                              .data()['itemPrice']
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
