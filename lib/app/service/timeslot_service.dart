import 'package:cloud_firestore/cloud_firestore.dart'hide Order;
import 'package:cloud_functions/cloud_functions.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_model.dart';
import '../models/time_slot_model.dart';

class TimeSlotService {

  Future<List<OrderModel>> getListAppointment(User use) async {
    final snapshot = await FirebaseFirestore.instance.collection('Order').where('userId', isEqualTo: use.uid).get();
    snapshot.docs.forEach(
          (lot) {
            print("msary + ${lot.data()['doctorId']}");
          },
    );
    return snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
  }

//  Future<List<TimeSlot>> getListAppointment(User user) async {
//     try {
//       var userId = user.uid;
//       var documentSnapshot = await FirebaseFirestore.instance
//           .collection('DoctorTimeslot')
//           .where('bookByWho.userId', isEqualTo: userId)
//           .where('charged', isEqualTo: true)
//           .get();
//
//       if (documentSnapshot.docs.isEmpty) {
//         return [];
//       }
//       List<TimeSlot> listTimeslot = documentSnapshot.docs.map((doc) {
//         var data = doc.data();
//         data['timeSlotId'] = doc.reference.id;
//         TimeSlot timeSlot = TimeSlot.fromJson(data);
//         return timeSlot;
//       }).toList();
//
//       return listTimeslot;
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

  Future<TimeSlot> getTimeSlotById(String timeslotId) async {
    try {
      var timeslotRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeslotId)
          .get();

      TimeSlot timeslot = TimeSlot.fromFirestore(timeslotRef);
      return timeslot;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future rescheduleTimeslot(
    TimeSlot timeSlotNow,
    TimeSlot timeslotChanged,
  ) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('rescheduleTimeslot');
      await callable({
        'timeSlotIdNow': timeSlotNow.timeSlotId,
        'timeslotChanged': timeslotChanged.timeSlotId
      });
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }
}
