// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final formState = GlobalKey<FormState>();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

bool isDataEntered = false;
bool isDataEntered2 = false;

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  RegExp emailRegExp = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegExp.hasMatch(email);
  if (!isEmailValid) {
    return 'Tolong masukkan email yang benar';
  }
  return null;
}

var customerId;
String? customerName;
dynamic customerAddress;
String? customerCity;
dynamic customerEmail;
int? customerNumberHp;

void getId(id) {
  customerId = id;
}

void getCustomerName(name) {
  customerName = name;
}

void getAddress(address) {
  customerAddress = address;
}

void getCity(city) {
  customerCity = city;
}

void getEmail(email) {
  customerEmail = email;
}

void getNoHp(number) {
  customerNumberHp = int.tryParse(number);
}

void saveToast() => Fluttertoast.showToast(
    msg: 'Data berhasil disimpan',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0);

void checkSaveToast() => Fluttertoast.showToast(
    msg: 'Customer dengan ID $customerId sudah ada.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

void updateToast() => Fluttertoast.showToast(
    msg: 'Data berhasil diedit',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.orangeAccent,
    textColor: Colors.white,
    fontSize: 16.0);

void checkUpdateToast() => Fluttertoast.showToast(
    msg: 'Tidak dapat mengedit, ID $customerId tidak ditemukan.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

void deleteToast() => Fluttertoast.showToast(
    msg: 'Data berhasil dihapus',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

void checkDeleteToast() => Fluttertoast.showToast(
    msg: 'Tidak dapat menghapus, ID $customerId tidak ditemukan.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

Future<void> checkAndAddData() async {
  // var customerId = idController2.text;

  DocumentSnapshot customerSnapshot =
      await firestore.collection('customers').doc(customerId).get();

  if (customerSnapshot.exists) {
    // Tampilkan pesan jika data sudah ada
    checkSaveToast();
  } else {
    // Tambahkan data baru ke Firebase
    await firestore.collection('customers').doc(customerId).set({
      'customerId': customerId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerCity': customerCity,
      'customerEmail': customerEmail,
      'customerNumberHP': customerNumberHp,
    }).then((value) => saveToast());
  }
}

void checkAndUpdateData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('customers').doc(customerId);

  // Periksa apakah customerId tidak kosong
  if (customerId.isEmpty) {
  } else {
    documentReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Data ditemukan, lakukan pembaruan dokumen
        documentReference.update({
          // Tambahkan bidang dan nilai yang akan diubah di sini
          'customerId': customerId,
          'customerName': customerName,
          'customerAddress': customerAddress,
          'customerCity': customerCity,
          'customerEmail': customerAddress,
          'customerNumberHP': customerNumberHp,
        }).then((value) => updateToast());
      } else {
        // CustomerId tidak ditemukan, tampilkan pesan kesalahan
        checkUpdateToast();
      }
    }).catchError((error) {
      // Penanganan kesalahan saat mengambil data
      if (kDebugMode) {
        print('Error: $error');
      }
    });
  }
}

void checkAndDeleteData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('customers').doc(customerId);

  documentReference.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      // Hapus dokumen menggunakan DocumentSnapshot
      documentReference.delete().then((value) => deleteToast());
    } else {
      // CustomerId tidak ditemukan, tampilkan pesan kesalahan
      checkDeleteToast();
    }
  }).catchError((error) {
    // Penanganan kesalahan saat mengambil data
    if (kDebugMode) {
      print('Error: $error');
    }
  });
}
