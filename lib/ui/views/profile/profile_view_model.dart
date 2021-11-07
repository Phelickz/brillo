import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ProfileViewModel extends CustomBaseViewModel {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  Future<void> init() async {
    await getUserData();
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _data = doc.data() as Map<String, dynamic>;
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
