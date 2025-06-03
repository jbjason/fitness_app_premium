import 'package:fitness_app_premium/momen_vhai/inventory_screen.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/cm_text_field.dart';
import 'package:flutter/material.dart';

class TopInputFields extends StatelessWidget {
  const TopInputFields(
      {super.key,
      required this.nameController,
      required this.numberController,
      required this.carTypeController,
      required this.carNoController,
      required this.addressController,
      required this.contactController,
      required this.dateController});
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController carTypeController;
  final TextEditingController carNoController;
  final TextEditingController addressController;
  final TextEditingController contactController;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: textHeightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "ক্যাশ মেমো",
            style: TextStyle(
                color: textSecondaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CmTextField(title: "নং:", controller: numberController),
            CmTextField(title: "গাড়ী:", controller: carTypeController),
            CmTextField(title: "তারিখঃ", controller: dateController),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CmTextField(
                  title: "নাম:", controller: nameController, width: null),
            ),
            CmTextField(title: "গাড়ী নং:", controller: carNoController),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CmTextField(
                  title: "ঠিকানা:", controller: addressController, width: null),
            ),
            CmTextField(title: "মোবাইল:", controller: contactController),
          ],
        ),
      ],
    );
  }
}
