import 'package:fitness_app_premium/momen_vhai/inventory_screen.dart';
import 'package:flutter/material.dart';

class InventoryTopTitles extends StatelessWidget {
  const InventoryTopTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("বিস্মিল্লাহির রাহমানির রাহিম",
            style: TextStyle(
                fontSize: 13,
                color: textHeightColor,
                fontWeight: FontWeight.bold)),
        Text("সাফা মটরস",
            style: TextStyle(
                fontSize: 40,
                color: textHeightColor,
                fontWeight: FontWeight.bold)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: textHeightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            "নিটল মটরসের অনুমোদিত ডিলার",
            style: TextStyle(
                color: textSecondaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "৭/১ (আই) জমজম মার্কেট, ১নং রেলগেইট তেজগাঁও ট্রাক স্ট্যান্ড, তেজগাঁও, ঢাকা-১২০৮",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              color: textHeightColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
