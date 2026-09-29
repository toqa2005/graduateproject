import 'package:flutter/material.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import '../../colors/Appcolors.dart';

class Avatar extends StatefulWidget {
  final String? initialAvatar;
  final ValueChanged<String>? onChanged;

  const Avatar({
    super.key,
    this.initialAvatar,
    this.onChanged,
  });

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final List<String> avatars = const [
    Appimages.Avatar1,
    Appimages.Avatar2,
    Appimages.Avatar3,
  ];

  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = avatars.contains(widget.initialAvatar)
        ? widget.initialAvatar!
        : avatars.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        avatars.length,
            (index) {
          final avatar = avatars[index];
          final selected = selectedAvatar == avatar;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatar = avatar;
              });
              widget.onChanged?.call(avatar);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.all(selected ? 3 : 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? Appcolor.yellow
                    : Colors.transparent,
              ),
              child: CircleAvatar(
                radius: selected ? 43 : 27,
                backgroundImage: AssetImage(avatar),
              ),
            ),
          );
        },
      ),
    );
  }
}
