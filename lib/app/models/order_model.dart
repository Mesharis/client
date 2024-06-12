


import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

class OrderModel {
  OrderModel({
    required this.itemId,
    required this.itemName,
    required this.time,
    required this.link,
    required this.duration,
    required this.price,
    required this.doctorId,
    required this.userId,
    required this.orderId,
    required this.username,
  });

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

  static const String _itemId = 'itemId';
  static const String _itemName = 'itemName';
  static const String _time = 'time';
  static const String _link = 'link';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _doctorId = 'doctorId';
  static const String _userId = 'userId';
  static const String _orderId = 'orderId';
  static const String _username = 'username';

  factory OrderModel.fromJson(Map<String, dynamic>? json) => OrderModel(
      itemId:  json![_itemId],
      itemName:json[_itemName],
      time: json[_time],
      link: List.from(json[_link] ?? []),
      duration:json[_duration],
      price: json[_price],
      doctorId: json[_doctorId],
      userId: json[_userId],
      orderId: json[_orderId],
      username: json[_username],
  );
}

class Order {
  Order({
    required this.itemId,
    required this.itemName,
    required this.time,
    required this.link,
    required this.duration,
    required this.price,
    required this.doctorId,
    required this.userId,
    required this.orderId,
    required this.username
  });

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


  static const String _itemId = 'itemId';
  static const String _itemName = 'itemName';
  static const String _time = 'time';
  static const String _link = 'link';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _doctorId = 'doctorId ';
  static const String _userId = 'userId';
  static const String _orderId = 'orderId';
  static const String _username = 'username';


  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        orderId: map[_orderId],
        itemId: map[_itemId],
        itemName: map[_itemName],
        time: map[_time],
        link: map[_link],
        duration: map[_duration],
        price: map[_price],
        doctorId: map[_doctorId],
        userId: map[_userId],
        username: map[_username]
    );
  }

}
