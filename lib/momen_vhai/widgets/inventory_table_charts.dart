import 'package:fitness_app_premium/momen_vhai/inventory_screen.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/cm_text_field.dart';
import 'package:fitness_app_premium/momen_vhai/widgets/inventory_item.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class InventoryTableCharts extends StatefulWidget {
  const InventoryTableCharts({super.key});
  @override
  State<InventoryTableCharts> createState() => _InventoryTableChartsState();
}

class _InventoryTableChartsState extends State<InventoryTableCharts> {
  final _productDetailsController = TextEditingController();
  final _supplierController = TextEditingController();
  final _barCodeController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  final productlist = [
    InventoryItem(
      id: "",
      productTitle: "Tester Product BD",
      supplier: "Tata",
      barCode: "854Hgf4",
      amount: "5",
      type: "10",
      price: "500",
    ),
    InventoryItem(
      id: "",
      productTitle: "Tester Product BD",
      supplier: "Tata",
      barCode: "854Hgf4",
      amount: "80",
      type: "100",
      price: "2500",
    ),
    InventoryItem(
      id: "",
      productTitle: "Tester Product BD",
      supplier: "Tata",
      barCode: "674Hf4",
      amount: "50",
      type: "200",
      price: "700",
    ),
    InventoryItem(
      id: "",
      productTitle: "Tester Product BD",
      supplier: "Tata",
      barCode: "854Hgf4",
      amount: "80",
      type: "30",
      price: "2500",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getTableItem(
          id: "নং",
          idBackColor: textThirdColor,
          productTitle: "মালের বিবরণ",
          productTitleBackColor: textThirdColor,
          supplier: "জোগানদার",
          supplierBackolor: textThirdColor,
          barCode: "বারকোড",
          barCodeBackolor: textThirdColor,
          amount: "পরিমাণ",
          amountBackColor: textThirdColor,
          type: "দর",
          typeBackColor: textThirdColor,
          price: "টাকা",
          priceBackColor: textThirdColor,
          textColor: textHeightColor,
          fontWeight: FontWeight.bold,
        ),
        ...List.generate(productlist.length, (index) {
          final item = productlist[index];
          return _getTableItem(
            id: (index + 1).toString(),
            productTitle: item.productTitle,
            supplier: item.supplier,
            barCode: item.barCode,
            amount: item.amount,
            type: item.type,
            price: item.price,
            textColor: Colors.black,
          );
        }),
        Row(
          children: [
            ElevatedButton(
              onPressed: _onAddButtonPress,
              style: ElevatedButton.styleFrom(
                backgroundColor: textHeightColor,
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Add Product"),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: _getItem(
                title: "মোট",
                backColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 160,
              child: _getItem(
                title: "500 /=",
                backColor: textThirdColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getTableItem({
    required String id,
    Color idBackColor = Colors.white,
    required String productTitle,
    Color productTitleBackColor = Colors.white,
    required String barCode,
    Color barCodeBackolor = Colors.white,
    required String supplier,
    Color supplierBackolor = Colors.white,
    required String amount,
    Color amountBackColor = textThirdColor,
    required String type,
    Color typeBackColor = Colors.white,
    required String price,
    Color priceBackColor = textThirdColor,
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: _getItem(
            title: id,
            backColor: idBackColor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        Expanded(
          child: _getItem(
            title: productTitle,
            backColor: productTitleBackColor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(
          width: 80,
          child: _getItem(
            title: supplier,
            backColor: supplierBackolor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(
          width: 70,
          child: _getItem(
            title: barCode,
            backColor: barCodeBackolor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(
          width: 60,
          child: _getItem(
            title: amount,
            backColor: amountBackColor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(
          width: 60,
          child: _getItem(
            title: type,
            backColor: typeBackColor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(
          width: 100,
          child: _getItem(
            title: "$price /=",
            backColor: priceBackColor,
            textColor: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }

  Widget _getItem({
    required String title,
    required Color backColor,
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: backColor,
        border: Border.all(color: textHeightColor, width: 1),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontWeight: fontWeight),
      ),
    );
  }

  void _onAddButtonPress() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: DraggableScrollableSheet(
            initialChildSize: .6,
            minChildSize: .5,
            maxChildSize: .9,
            builder: (_, ScrollController controller) => Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: ListView(
                controller: controller,
                children: [
                  // titlte
                  Center(
                    child: Text(
                      'Add Product',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CmTextField(
                    title: "মালের বিবরণ",
                    controller: _productDetailsController,
                    width: null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CmTextField(
                          title: "জোগানদার",
                          controller: _supplierController,
                          width: null,
                        ),
                      ),
                      Expanded(
                        child: CmTextField(
                          title: "বারকোড",
                          controller: _barCodeController,
                          width: null,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CmTextField(
                          title: "পরিমাণ",
                          controller: _amountController,
                        ),
                      ),
                      Expanded(
                        child: CmTextField(
                          title: "দর",
                          controller: _typeController,
                        ),
                      ),
                      Expanded(
                        child: CmTextField(
                          title: "টাকা",
                          controller: _priceController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _onAddProduct,
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onAddProduct() {
    productlist.add(InventoryItem(
      id: "",
      productTitle: _productDetailsController.text.trim(),
      supplier: _supplierController.text.trim(),
      barCode: _barCodeController.text.trim(),
      amount: _amountController.text.trim(),
      type: _typeController.text.trim(),
      price: _priceController.text.trim(),
    ));
    setState(() {});
    Logger().w("Product added: ${_productDetailsController.text.trim()}");
    Logger().w("length: ${productlist.length}");
    _productDetailsController.clear();
    _supplierController.clear();
    _barCodeController.clear();
    _amountController.clear();
    _typeController.clear();
    _priceController.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _productDetailsController.dispose();
    _supplierController.dispose();
    _barCodeController.dispose();
    _amountController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
