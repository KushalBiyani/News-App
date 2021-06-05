import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
User user = FirebaseAuth.instance.currentUser;
final _firestore = FirebaseFirestore.instance;

Future signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
}

Future logOut() async {
  await FirebaseAuth.instance.signOut();
  await googleSignIn.disconnect();
  await googleSignIn.signOut();
}

Future<Map> getDetails(currentUserId) async {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUserId)
      .get();
  return result.docs[0].data();
}

Future registerUser(firebaseUser) async {
  final QuerySnapshot result = await _firestore
      .collection('users')
      .where('id', isEqualTo: firebaseUser.uid)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  if (documents.length == 0) {
    // Update data to server if new user
    _firestore.collection('users').doc(firebaseUser.uid).set({
      'nickname': firebaseUser.displayName,
      'photoUrl': firebaseUser.photoURL,
      'id': firebaseUser.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}
