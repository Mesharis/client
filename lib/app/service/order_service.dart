import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/order_detail_model.dart';
import '../models/order_model.dart';
import '../models/time_slot_model.dart';
import 'user_service.dart';

class OrderService {

  Future<Order> getSuccessOrder(TimeSlot timeSlot) async {
    try {
      var orderSnapshot = await FirebaseFirestore.instance.collection('Order').where('timeSlotId', isEqualTo: timeSlot.timeSlotId).where('status', isEqualTo: 'payment_success').limit(1).get();
      var data = orderSnapshot.docs.elementAt(0).data();
      data['orderId'] = orderSnapshot.docs.elementAt(0).reference.id;
      Order order = Order.fromMap(data);
      return order;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<Order> getOrder(TimeSlot timeSlot) async {
    try {
      var orderData = await FirebaseFirestore.instance.collection('Order').where('userId', isEqualTo: UserService().getUserId()).where('timeSlotId', isEqualTo: timeSlot.timeSlotId).get();
      print('order length : ${orderData.docs.length}');
      var data = orderData.docs.elementAt(0).data();
      data['orderId'] = orderData.docs.elementAt(0).reference.id;
      Order order = Order.fromMap(data);
      return order;
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createOrder(OrderDetailModel order) async {
    try {
      String id = FirebaseFirestore.instance.collection("Order").doc().id;
      await FirebaseFirestore.instance.collection("Order").doc(id).set({
        'itemId': order.itemId,
        'itemName': order.itemName,
        'time': order.time,
        'link': order.link,
        'amount': order.price.toInt(),
        'createdAt': DateTime.now(),
        'status': 'success',
        'type': 'Done',
        'duration': order.duration,
        'price': order.price,
        'doctorId': order.doctorId,
        'userId': order.userId,
        'orderId': id,
        'username': order.username,
      });
      return id;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future confirmOrder(TimeSlot timeSlot) async {
    try {
      var order = await getOrder(timeSlot);
      return setOrderToComplete(order);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> setOrderToComplete(Order order) async {
    await FirebaseFirestore.instance
        .collection("Order")
        .doc(order.orderId)
        .update({'status': 'success'});
  }
}
