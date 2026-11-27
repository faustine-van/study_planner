import 'package:cloud_firestore/cloud_firestore.dart';


Future<String> insertGoal(Map<String, dynamic> goal) async {
  final res = await FirebaseFirestore.instance.collection('goals').add({
    'subject': goal['subject'],
    'hours': goal['hours'],
    'done': false,
  });
  return res.id;
}

Future<List<Map<String, dynamic>>> getGoals() async {
  final snapshot = await FirebaseFirestore.instance.collection('goals').get();
  return snapshot.docs.map((doc) {
    return {...doc.data(), 'id': doc.id};
  }).toList();
}

Future<void> updateGoal(String id, bool done) async {
  await FirebaseFirestore.instance.collection('goals').doc(id).update({
    'done': done,
  });
}

Future<void> deleteGoal(String id) async {
  await FirebaseFirestore.instance.collection('goals').doc(id).delete();
}
