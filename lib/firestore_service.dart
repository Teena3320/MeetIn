import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///  Check if user already exists (by email or phone)
  Future<bool> checkUserExists(String? email, String? phone) async {
    if (email != null) {
      var queryEmail =
          await _db.collection("users").where("email", isEqualTo: email).get();
      if (queryEmail.docs.isNotEmpty) return true;
    }

    if (phone != null) {
      var queryPhone =
          await _db.collection("users").where("phone", isEqualTo: phone).get();
      if (queryPhone.docs.isNotEmpty) return true;
    }

    return false; // No duplicate found
  }

  ///  Get the next available UID (Thread-Safe)
  Future<int> _getNextUID() async {
    DocumentReference counterRef = _db
        .collection("counters")
        .doc("user_counter");

    return _db.runTransaction((transaction) async {
      DocumentSnapshot counterSnapshot = await transaction.get(counterRef);

      int currentCount =
          counterSnapshot.exists ? (counterSnapshot["count"] ?? 0) : 0;
      int newUID = currentCount + 1;

      transaction.set(counterRef, {"count": newUID}); // Update counter safely
      return newUID;
    });
  }

  ///  Create a new user with a unique UID
  Future<int> createUser({String? email, String? phone}) async {
    if (email == null && phone == null) {
      throw Exception("Either email or phone must be provided!");
    }

    int newUID = await _getNextUID();

    await _db.collection("users").doc("UID$newUID").set({
      "uid": newUID,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      "createdAt": FieldValue.serverTimestamp(),
    });

    print("✅ User created: UID$newUID");
    return newUID;
  }
}
