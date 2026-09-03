import 'package:flutter/material.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  int selectedAvatar = 1;

  final List<String> avatars = [
   Appimages. Avatar1,
   Appimages. Avatar2,
   Appimages. Avatar3,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        avatars.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedAvatar = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: EdgeInsets.all(
              selectedAvatar == index ? 3 : 0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedAvatar == index
                  ? Appcolor.yellow
                  : Colors.transparent,
            ),
            child: CircleAvatar(
              radius: selectedAvatar == index ? 43 : 27,
              backgroundImage: AssetImage(
                avatars[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}