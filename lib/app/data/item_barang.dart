// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final formState = GlobalKey<FormState>();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

bool isDataEntered = false;
bool isDataEntered2 = false;

var itemId;
String? itemName;
var itemWeight;
String? itemDescription;
var itemTotal;
var itemPrice;

void getId(id) {
  itemId = id;
}

void getName(name) {
  itemName = name;
}

void getDescription(description) {
  itemDescription = description;
}

void getWeightItem(weightItem) {
  itemWeight = weightItem;
}

void getTotalItem(total) {
  // itemTotal = int.tryParse(total);
  itemTotal = total;
}

void getPriceItem(price) {
  itemPrice = price;
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
    msg: 'Kode Barang dengan ID $itemId sudah ada.',
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
    msg: 'Tidak dapat mengedit, ID $itemId tidak ditemukan.',
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
    msg: 'Tidak dapat menghapus, ID $itemId tidak ditemukan.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

Future<void> checkAndAddData() async {
  DocumentSnapshot customerSnapshot =
      await firestore.collection('itembarang').doc(itemId).get();

  if (customerSnapshot.exists) {
    // Tampilkan pesan jika data sudah ada
    checkSaveToast();
  } else {
    // Tambahkan data baru ke Firebase
    await firestore.collection('itembarang').doc(itemId).set({
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemWeight': itemWeight,
      'itemTotal': itemTotal,
      'itemPrice': itemPrice
    }).then((value) => saveToast());
  }
}

void checkAndUpdateData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('itembarang').doc(itemId);

  // Periksa apakah customerId tidak kosong
  if (itemId.isEmpty) {
  } else {
    documentReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Data ditemukan, lakukan pembaruan dokumen
        documentReference.update({
          // Tambahkan bidang dan nilai yang akan diubah di sini
          'itemId': itemId,
          'itemName': itemName,
          'itemDescription': itemDescription,
          'itemWeight': itemWeight,
          'itemTotal': itemTotal,
          'itemPrice': itemPrice
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
      FirebaseFirestore.instance.collection('itembarang').doc(itemId);

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
