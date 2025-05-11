import 'dart:io';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_dialog.dart';
import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:fitness_app_premium/features/auth/presentation/widgets/auth_buttons.dart';
import 'package:fitness_app_premium/features/auth/presentation/widgets/auth_clippers.dart';
import 'package:fitness_app_premium/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:fitness_app_premium/features/auth/presentation/widgets/auth_user_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/screens/onboard_screen.dart';
import 'package:flutter/material.dart';

class AuhtBody extends StatefulWidget {
  const AuhtBody({super.key});
  @override
  State<AuhtBody> createState() => _AuhtBodyState();
}

class _AuhtBodyState extends State<AuhtBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _isLoading = ValueNotifier<bool>(false);
  File? _userImageFile;
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      height: _isLogin ? size.height * .5 : size.height * .65,
      width: size.width * .8,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: MyDimens.loginGradient,
      ),
      child: ClipPath(
        clipper: AuthClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
          decoration: BoxDecoration(
            color: MyColor.logBackColor,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // login text & Image circleAvatar
              AuthUserImage(isLogin: _isLogin, pickedImage: _pickedImage),
              SizedBox(height: _isLogin ? 36 : 15),
              // email textfield
              AuthTextField(controller: _emailController, title: 'Email'),
              // username textfield
              if (!_isLogin)
                AuthTextField(controller: _nameController, title: 'Username'),
              // pass textfield
              AuthTextField(controller: _passController, title: 'Password'),
              const SizedBox(height: 20),
              // submit, signup & sigin buttons
              AuthButtons(
                isLogin: _isLogin,
                isLoading: _isLoading,
                onTrySignUp: onTrySignUp,
                onSubmit: _onSubmit,
              ),
            ],
          ),
        ),
      );

  void onTrySignUp() => setState(() => _isLogin = !_isLogin);

  void _pickedImage(File image) => _userImageFile = image;

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      MyDialog().showInfoToast(msg: 'Please pick an image', context: context);
      return;
    }
    // _emailController.text.trim();
    // _nameController.text.trim();
    // _passController.text.trim();
    // _userImageFile != null ? _userImageFile! : File('');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OnboardScreen()),
    );
  }
}
