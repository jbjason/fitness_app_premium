import 'dart:io';
import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthUserImage extends StatefulWidget {
  const AuthUserImage(
      {super.key, required this.isLogin, required this.pickedImage});
  final void Function(File pickedImage) pickedImage;
  final bool isLogin;
  @override
  State<AuthUserImage> createState() => _AuthUserImageState();
}

class _AuthUserImageState extends State<AuthUserImage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isLogin) ...[
          Center(
            child: Text(
              'LOGIN',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ] else ...[
          // circle avatar
          _circleAvatar(),
          // image source icon like Camera & Gallery
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageIcon(ImageSource.camera, Icons.camera_alt_sharp),
              const Text('Add image', style: TextStyle(color: Colors.white70)),
              _imageIcon(ImageSource.gallery, Icons.image),
            ],
          ),
        ],
      ],
    );
  }

  CircleAvatar _circleAvatar() {
    return CircleAvatar(
      radius: 35,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: MyDimens.loginGradient,
        ),
        child: _image == null
            ? Container()
            : CircleAvatar(radius: 33.5, backgroundImage: FileImage(_image!)),
      ),
    );
  }

  IconButton _imageIcon(ImageSource source, IconData icon) {
    return IconButton(
      onPressed: () => _pickImage(source),
      icon: Icon(icon, color: Colors.white70),
    );
  }

  void _pickImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(
      source: source,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    setState(() => _image = File(img!.path));
    widget.pickedImage(_image!);
  }
}
