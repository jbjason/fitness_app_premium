// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_listitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Profile Section
        ProfileAppbar(),
        // Post Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileListItem(icon: Icons.person_outline, title: 'Profile'),
                  ProfileListItem(
                      icon: Icons.lock_clock, title: 'Daily Reminder'),
                  ProfileListItem(
                      icon: CupertinoIcons.settings, title: 'Settings'),
                  ProfileListItem(
                      icon: Icons.privacy_tip_outlined, title: "Our Policies"),
                  ProfileListItem(icon: Icons.info_outline, title: 'About App'),
                  ProfileListItem(icon: Icons.logout, title: 'Logout'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
