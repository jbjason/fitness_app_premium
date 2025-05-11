import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.title,
    super.key,
  });
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title text
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        const SizedBox(height: 2),
        //  textfield
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: MyDimens.loginGradient,
          ),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 13, color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              errorStyle: TextStyle(color: Colors.white, fontSize: 11),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) {
              if (title.toLowerCase() == 'email') {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              } else if (title.toLowerCase() == 'username') {
                if (value!.isEmpty) {
                  return 'UserName should be 4 characters atleast';
                }
                return null;
              } else {
                if (value!.isEmpty || value.length <= 4) {
                  return 'Password should be 4 characters atleast';
                }
                return null;
              }
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
