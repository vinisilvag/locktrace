import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locktrace/models/trace.dart';

class TraceService {
  static final TraceService _instance = TraceService._internal();
  factory TraceService() => _instance;
  TraceService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Trace>> watchTraces(String uid) {
    return _firestore
        .collection('traces')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(8)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Trace.fromDoc(doc.id, doc.data()))
              .toList();
        });
  }

  Future<void> createTrace({
    required String userUid,
    required bool roomWindow,
    required bool roomOutlet,
    required bool kitchenOutlet,
    required bool burner,
    required bool clothesIron,
  }) async {
    await _firestore.collection("traces").add({
      "uid": userUid,
      "roomWindow": roomWindow,
      "roomOutlet": roomOutlet,
      "kitchenOutlet": kitchenOutlet,
      "burner": burner,
      "clothesIron": clothesIron,
      "createdAt": DateTime.timestamp(),
    });
  }

  Future<void> deleteTrace(String id) async {
    await _firestore.collection("traces").doc(id).delete();
  }
}
