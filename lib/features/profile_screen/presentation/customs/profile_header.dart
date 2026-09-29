import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/core/widgets/custom/button.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final int watchListCount;
  final int historyCount;
  final String? avatarAsset;
  final String? customAvatarBase64;
  final VoidCallback onEdit;
  final VoidCallback onLogout;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.watchListCount,
    required this.historyCount,
    required this.avatarAsset,
    required this.customAvatarBase64,
    required this.onEdit,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? customBytes;
    if (customAvatarBase64 != null && customAvatarBase64!.isNotEmpty) {
      try {
        customBytes = base64Decode(customAvatarBase64!);
      } catch (_) {}
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
      child: Column(
        children: [
          SizedBox(
            height: 102,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 31,
                        backgroundColor: Appcolor.lightgray,
                        backgroundImage: customBytes != null
                            ? MemoryImage(customBytes)
                            : AssetImage(avatarAsset ?? Appimages.Avatar1)
                                  as ImageProvider,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Appcolor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _Counter(value: watchListCount, label: 'Wish List'),
                ),
                Expanded(
                  child: _Counter(value: historyCount, label: 'History'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: CustomButton(
                    text: 'Edit Profile',
                    colorbutton: Appcolor.yellow,
                    colortext: Appcolor.black,
                    onPressed: onEdit,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: CustomButton(
                    text: 'Exit',
                    colorbutton: Appcolor.red,
                    colortext: Appcolor.white,
                    icon: Icons.logout,
                    onPressed: onLogout,
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  final int value;
  final String label;

  const _Counter({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$value',
          style: const TextStyle(
            color: Appcolor.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Appcolor.white, fontSize: 13),
        ),
      ],
    );
  }
}
