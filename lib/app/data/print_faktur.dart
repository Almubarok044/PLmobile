// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plmobile/app/modules/controllers/pdf.dart';

final formState = GlobalKey<FormState>();
final FirebaseFirestore firestore = FirebaseFirestore.instance;
dynamic dateSelected = DateTime.now();

bool isDataEntered = false;
bool isDataEntered2 = false;

var fakturId;
String? typeOfPayment;

var customerId;
String? customerName;
dynamic customerAddress;
int? customerNumberHp;

var itemIdFaktur;
String? itemNameFaktur;
var itemWeightFaktur;
var itemTotalFaktur;
var itemPriceFaktur;

void getIdFaktur(id) {
  fakturId = id;
}

void getTypeOfPayment(payment) {
  typeOfPayment = payment;
}

void getCustomerId(idCustomer) {
  customerId = idCustomer;
}

void getCustomerName(nameCustomer) {
  customerName = nameCustomer;
}

void getCustomerAddress(addressCustomer) {
  customerAddress = addressCustomer;
}

void getNoHp(numberCustomer) {
  customerNumberHp = int.tryParse(numberCustomer);
}

void getIdItem(idItem) {
  itemIdFaktur = idItem;
}

void getNameItem(nameItem) {
  itemNameFaktur = nameItem;
}

void getWeightItem(weightItem) {
  itemWeightFaktur = weightItem;
}

void getTotalItem(totalItem) {
  // itemTotalFaktur = int.tryParse(totalItem);
  itemTotalFaktur = totalItem;
}

void getPriceItem(priceItem) {
  itemPriceFaktur = priceItem;
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
    msg: 'No. Faktur dengan ID $fakturId sudah ada.',
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
    msg: 'Tidak dapat mengedit, ID $fakturId tidak ditemukan.',
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
    msg: 'Tidak dapat menghapus, ID $fakturId tidak ditemukan.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

void checkPDFToast() => Fluttertoast.showToast(
    msg: 'Tidak dapat membuka PDF, ID $fakturId tidak ditemukan.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0);

void pdfToast() => Fluttertoast.showToast(
    msg: 'Berhasil membuka PDF dengan ID $fakturId.',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.indigo,
    textColor: Colors.white,
    fontSize: 16.0);

Future<void> checkAndAddData() async {
  DocumentSnapshot customerSnapshot =
      await firestore.collection('faktur').doc(fakturId).get();

  if (customerSnapshot.exists) {
    // Tampilkan pesan jika data sudah ada
    checkSaveToast();
  } else {
    // Tambahkan data baru ke Firebase
    await firestore.collection('faktur').doc(fakturId).set({
      'fakturId': fakturId,
      'dateSelected': dateSelected,
      'typeOfPayment': typeOfPayment,
      'customerId': customerId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerNumberHP': customerNumberHp,
      'itemIdFaktur': itemIdFaktur,
      'itemNameFaktur': itemNameFaktur,
      'itemWeightFaktur': itemWeightFaktur,
      'itemTotalFaktur': itemTotalFaktur,
      'itemPriceFaktur': itemPriceFaktur
    }).then((value) => saveToast());
  }
}

void checkAndUpdateData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('faktur').doc(fakturId);

  // Periksa apakah customerId tidak kosong
  if (customerId.isEmpty) {
  } else {
    documentReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Data ditemukan, lakukan pembaruan dokumen
        documentReference.update({
          // Tambahkan bidang dan nilai yang akan diubah di sini
          'fakturId': fakturId,
          'dateSelected': dateSelected,
          'typeOfPayment': typeOfPayment,
          'customerId': customerId,
          'customerName': customerName,
          'customerAddress': customerAddress,
          'customerNumberHP': customerNumberHp,
          'itemIdFaktur': itemIdFaktur,
          'itemNameFaktur': itemNameFaktur,
          'itemWeightFaktur': itemWeightFaktur,
          'itemTotalFaktur': itemTotalFaktur,
          'itemPriceFaktur': itemPriceFaktur
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
      FirebaseFirestore.instance.collection('faktur').doc(fakturId);

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

void checkAndPDFData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('faktur').doc(fakturId);

  documentReference.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      // Hapus dokumen menggunakan DocumentSnapshot
      getFilePdf().then((value) => pdfToast());
      // documentReference.delete().then((value) => deleteToast());
    } else {
      // CustomerId tidak ditemukan, tampilkan pesan kesalahan
      checkPDFToast();
    }
  }).catchError((error) {
    // Penanganan kesalahan saat mengambil data
    if (kDebugMode) {
      print('Error: $error');
    }
  });
}

// if (dateSelected) {
//       // Format the date as needed before saving to Firestore
//       String formatedDate = DateFormat('yyyy-MM-dd').format(dateSelected);

//       // Add the formatted date to Firestore
//       FirebaseFirestore.instance.collection('faktur').add({
//         'dateSelected': formatedDate,
//       }).then((value) => saveToast());
//     }