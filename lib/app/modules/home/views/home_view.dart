import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Text(
                'Koleksiku Punyaku',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout_outlined,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  var item = controller.items[index];
                  return ListTile(
                    leading: Image.network(
                      item.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tahun Beli: ${item.tahun}'),
                        Text('Deskripsi: ${item.deskripsi}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddItemDialog(controller: controller);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddItemDialog extends StatefulWidget {
  final HomeController controller;

  const AddItemDialog({Key? key, required this.controller}) : super(key: key);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final ImagePicker _picker = ImagePicker();
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = File('');
  }

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Tambah Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _imageFile.path.isEmpty
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : Image.file(_imageFile, fit: BoxFit.cover),
              ),
            ),
            TextField(
              controller: widget.controller.namaController,
              decoration: const InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: widget.controller.tahunController,
              decoration: const InputDecoration(labelText: 'Tahun Beli'),
            ),
            TextField(
              controller: widget.controller.deskripsiController,
              decoration: const InputDecoration(labelText: 'Deskripsi Barang'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await widget.controller.simpanData(_imageFile);
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
