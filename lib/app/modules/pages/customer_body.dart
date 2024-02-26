import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerBody extends StatefulWidget {
  const CustomerBody({super.key, required List<Padding> children});

  @override
  State<CustomerBody> createState() => _CustomerBodyState();
}

class _CustomerBodyState extends State<CustomerBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          title: const Text('List Customer',
              style: TextStyle(color: Colors.white)),
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
                        .collection('customers')
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
                                    color: Colors.lightGreen[400]),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                height: 200,
                                child: Column(
                                  children: [
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
                                        const Text('Kota : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerCity']
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
                                        const Text('Email : '),
                                        Expanded(
                                          child: Text(documentSnapshot
                                              .data()['customerEmail']
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
