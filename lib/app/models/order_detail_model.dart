class OrderDetailModel {
  final String itemId;
  final String itemName;
  final String time;
  final List<String> link;
  final String duration;
  final String price;
  final String doctorId;
  final String userId;
  final String orderId;
  final String username;
  OrderDetailModel(
      {required this.itemId,
      required this.itemName,
      required this.time,
      required this.link,
      required this.duration,
      required this.doctorId,
      required this.userId,
      required this.username,
      required this.orderId,
      required this.price});
}
