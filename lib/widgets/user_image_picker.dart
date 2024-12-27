import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
    _pickedImageFile = File(pickedImage.path);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pickedImageFile != null
            ? CircleAvatar(
          backgroundImage: FileImage(_pickedImageFile!),
          radius: 50,
        )
            : CircleAvatar(
          child: Icon(Icons.add_a_photo, size: 30),
          radius: 50,
          backgroundColor: Colors.grey[300],
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
