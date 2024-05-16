import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  RxList<Item> items = <Item>[].obs;

  final namaController = TextEditingController();
  final tahunController = TextEditingController();
  final deskripsiController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  @override
  void onClose() {
    namaController.dispose();
    tahunController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }

  Future<void> simpanData(File imageFile) async {
    String nama = namaController.text.trim();
    int tahun = int.tryParse(tahunController.text.trim()) ?? 0;
    String deskripsi = deskripsiController.text.trim();

    if (nama.isNotEmpty &&
        tahun > 0 &&
        deskripsi.isNotEmpty &&
        imageFile.path.isNotEmpty) {
      try {
        String imageUrl = await uploadImage(imageFile);

        await FirebaseFirestore.instance.collection('items').add({
          'nama': nama,
          'tahun': tahun,
          'deskripsi': deskripsi,
          'imageUrl': imageUrl,
        });

        namaController.clear();
        tahunController.clear();
        deskripsiController.clear();

        loadItems();
      } catch (e) {
        print('Error saving data: $e');
      }
    }
  }

  Future<String> uploadImage(File imageFile) async {
    throw 'Image upload failed';
  }

  void loadItems() {
    try {
      FirebaseFirestore.instance
          .collection('items')
          .snapshots()
          .listen((snapshot) {
        items.value =
            snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }
}

class Item {
  final String nama;
  final int tahun;
  final String deskripsi;
  final String imageUrl;

  Item(
      {required this.nama,
      required this.tahun,
      required this.deskripsi,
      required this.imageUrl});

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Item(
      nama: data['nama'] ?? '',
      tahun: data['tahun'] ?? 0,
      deskripsi: data['deskripsi'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
