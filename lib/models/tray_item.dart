class TrayItem {
  final int id;
  final String name, imagePath, screenId;
  int price, amount;
  TrayItem(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.price,
      required this.screenId,
      required this.amount});
}
