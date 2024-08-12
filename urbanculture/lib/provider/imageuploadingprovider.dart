import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbanculture/provider/skincareprovider.dart';
import 'package:urbanculture/utills/comman_widgets.dart';

class Imageuploadingprovider with ChangeNotifier {
  final Map<String, bool> _uploadingStatus = {};

  bool isUploading(String step) => _uploadingStatus[step] ?? false;

  void _setUploading(String step, bool uploading) {
    _uploadingStatus[step] = uploading;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context, String step) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      _setUploading(step, true);

      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        String path =
            'uploads/$step/${DateTime.now().millisecondsSinceEpoch}.jpg';

        await storage.ref(path).putFile(file);

        CommanWidgets.flushBarSuccessMessage("Uploaded successfully", context);

        print('File uploaded successfully for step: $step');

        final skincareProvider =
            Provider.of<SkincareProvider>(context, listen: false);
        skincareProvider.checkAndUpdateStreak(context);
      } catch (e) {
        print('Error uploading file: $e');
      } finally {
        _setUploading(step, false);
      }
    } else {
      print('No image selected.');
    }
  }
}
