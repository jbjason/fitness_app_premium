import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/cm_text_field.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/inventory_contacts.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/inventory_table_charts.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/inventory_top_input_fields.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/inventory_top_titles.dart';
import 'package:flutter/material.dart';

final textHeightColor = Colors.blue[900]!;
const textSecondaryColor = Colors.white;
const textThirdColor = Color(0xFFBBDEFB);

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _carTypeController = TextEditingController();
  final _carNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _dateController = TextEditingController(text: "01/01/2023");
  final _amountInWordsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              // contacts, bkashNo
              Positioned(
                  top: 10, left: 0, right: 0, child: InventoryContacts()),
              // body
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // title, subtitle, address
                    InventoryTopTitles(),
                    const SizedBox(height: 15),
                    // No, CarType, Date, Name, CarNo, Address, Contact fields
                    TopInputFields(
                      nameController: _nameController,
                      numberController: _numberController,
                      carTypeController: _carTypeController,
                      carNoController: _carNoController,
                      addressController: _addressController,
                      contactController: _contactController,
                      dateController: _dateController,
                    ),
                    const SizedBox(height: 15),
                    InventoryTableCharts(),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: context.screenWidth,
                      child: CmTextField(
                        title: "ঠিকানা:",
                        controller: _amountInWordsController,
                        width: 300,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      color: textThirdColor,
                      child: Text(
                        "বিক্রিত মাল/পার্টস নষ্ট না হলে ফেরত নেওয়া হয়। কিন্তু যদি পণ্যের প্যাকেট ক্ষতিগ্রস্ত হয় তাহলে তা ফেরত দেওয়া হয় না।",
                        style: TextStyle(
                          color: textHeightColor,
                            fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _carTypeController.dispose();
    _carNoController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _dateController.dispose();
    _amountInWordsController.dispose();
    super.dispose();
  }
}
