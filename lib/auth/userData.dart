import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class UserDatabaseService {
  UserDatabaseService({this.uid});
  final String uid;

  final CollectionReference brewCollection = _firestore.collection('brews');

  Future updateUserData(String name, String email, String upiId, String aadhar,
      String dob, int vehicle, String vehicleNo) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'email': email,
      'upi': upiId,
      'aadhar': aadhar,
      'dob': dob,
      'vehicle': vehicle,
      'vehicle_no': vehicleNo,

    });
  }
}
