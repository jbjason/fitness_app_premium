import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem(
      {super.key, required this.icon, required this.title, this.trailing});
  final IconData icon;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: MyColor.textThird),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w300),
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 17),
    );
  }
}
