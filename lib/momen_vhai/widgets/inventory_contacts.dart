import 'package:fitness_app_premium/momen_vhai/inventory_screen.dart';
import 'package:flutter/material.dart';

class InventoryContacts extends StatelessWidget {
  const InventoryContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: textHeightColor),
          ),
          child: Row(
            children: [
              Icon(Icons.g_mobiledata),
              const SizedBox(width: 5),
              Text(
                "01816-757571",
                style: TextStyle(
                    color: textHeightColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Icon(Icons.g_mobiledata),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              "01915-490071",
              style: TextStyle(
                  color: textHeightColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "01911-474271",
              style: TextStyle(
                  color: textHeightColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
