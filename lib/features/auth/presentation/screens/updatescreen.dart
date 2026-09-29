import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/core/routes/routsapp.dart';
import 'package:graduateproject/core/widgets/Appbar.dart';
import 'package:graduateproject/core/widgets/custom/CustomField.dart';
import 'package:graduateproject/core/widgets/custom/Customtextbutton.dart';
import 'package:graduateproject/core/widgets/custom/button.dart';
import 'package:graduateproject/features/auth/data/auth_repository.dart';
import 'package:graduateproject/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduateproject/features/auth/presentation/cubit/authstate.dart';
import 'package:image_picker/image_picker.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  late final AuthCubit authCubit;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String selectedAvatar = Appimages.Avatar1;
  Uint8List? customAvatarBytes;
  bool clearCustomAvatar = false;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit(AuthRepository());
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    nameController.text = user?.displayName ?? '';
    phoneController.text = user?.phoneNumber ?? '';

    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = snapshot.data() ?? {};
    final avatar = data['avatarAsset'];
    final custom = data['customAvatarBase64'];

    if (!mounted) return;

    setState(() {
      if (avatar is String && avatar.isNotEmpty) {
        selectedAvatar = avatar;
      }

      if (custom is String && custom.isNotEmpty) {
        try {
          customAvatarBytes = base64Decode(custom);
        } catch (_) {}
      }
    });
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();

    if (!mounted) return;

    setState(() {
      customAvatarBytes = bytes;
      clearCustomAvatar = false;
    });
  }

  Future<void> _updateProfile() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final customBase64 = customAvatarBytes == null
        ? null
        : base64Encode(customAvatarBytes!);

    await authCubit.updateProfile(
      name: name,
      phone: phone,
      avatarAsset: selectedAvatar,
      customAvatarBase64: customBase64,
      clearCustomAvatar: clearCustomAvatar,
    );

    if (!mounted) return;

    if (authCubit.state is AuthUpdateSuccess) {
      Navigator.of(context).pop();
      return;
    }

    if (authCubit.state is AuthFailure) {
      final state = authCubit.state as AuthFailure;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Appcolor.red,
          content: Text(
            state.message,
            style: const TextStyle(color: Appcolor.white),
          ),
        ),
      );
    }
  }

  Future<void> _deleteAccount() async {
    if (_deleting) return;

    final passwordController = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Appcolor.black,
          title: const Text(
            'Delete Account',
            style: TextStyle(color: Appcolor.white),
          ),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            autofocus: true,
            style: const TextStyle(color: Appcolor.white),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: const TextStyle(color: Colors.white54),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white24),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Appcolor.yellow),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () {
                final value = passwordController.text.trim();
                if (value.isEmpty) return;
                Navigator.pop(dialogContext, value);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Appcolor.red),
              ),
            ),
          ],
        );
      },
    );

    passwordController.dispose();

    if (password == null || password.isEmpty || !mounted) return;

    setState(() => _deleting = true);

    await authCubit.deleteAccount(password: password);

    if (!mounted) return;

    if (authCubit.state is AuthDeleteSuccess) {
      // The Auth user has already been deleted. Do not show a SnackBar here.
      // Replace the whole navigation stack with Login.
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routes.loginscreen, (route) => false);
      return;
    }

    setState(() => _deleting = false);

    if (authCubit.state is AuthFailure) {
      final state = authCubit.state as AuthFailure;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Appcolor.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          content: Text(
            state.message,
            style: const TextStyle(color: Appcolor.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      appBar: const CustomAppbar(text: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Appcolor.yellow, width: 3),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: customAvatarBytes != null
                      ? MemoryImage(customAvatarBytes!)
                      : AssetImage(selectedAvatar) as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 26),
            CustomField(
              hintText: 'Name',
              icon: Icons.person,
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 15),
            CustomField(
              hintText: 'Phone',
              icon: Icons.call,
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: textbutton(
                text: 'Reset Password',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgetpassword);
                },
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: _deleting ? 'Deleting...' : 'Delete Account',
              colorbutton: Appcolor.red,
              colortext: Appcolor.white,
              onPressed: _deleting ? null : _deleteAccount,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Update Data',
              colorbutton: Appcolor.yellow,
              colortext: Appcolor.black,
              onPressed: _deleting ? null : _updateProfile,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
