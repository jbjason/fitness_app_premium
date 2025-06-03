class InventoryItem {
  final String id;
  final String productTitle;
  final String supplier;
  final String barCode;
  final String amount;
  final String type;
  final String price;
  const InventoryItem({
    required this.id,
    required this.productTitle,
    required this.supplier,
    required this.barCode,
    required this.amount,
    required this.type,
    required this.price,
  });
}
