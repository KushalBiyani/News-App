import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
User user = FirebaseAuth.instance.currentUser;
final _firestore = FirebaseFirestore.instance;

User currentUser = FirebaseAuth.instance.currentUser;
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

void addsaved(uid, Article article) async {
  _firestore.collection('users').doc(uid).collection('saved').add({
    "author": article.author,
    "source": {
      "id": article.source.id,
      "name": article.source.name,
    },
    "title": article.title,
    "description": article.description,
    "url": article.url,
    "urlToImage": article.urlToImage,
    "content": article.content,
    'addedAt': DateTime.now().millisecondsSinceEpoch.toString()
  });
}

Stream getSaved(uid) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('saved')
      .orderBy('addedAt', descending: true)
      .snapshots();
}

Future<bool> checkPresent(String url, uid) async {
  QuerySnapshot result = await _firestore
      .collection('users')
      .doc(uid)
      .collection('saved')
      .where('url', isEqualTo: url)
      .get();
  if (result.docs.length == 0) {
    return false;
  }
  return true;
}

void deleteItem(String url) async {
  _firestore
      .collection('users')
      .doc(currentUser.uid)
      .collection('saved')
      .where('url', isEqualTo: url)
      .get()
      .then(
        (querySnapshot) => {
          querySnapshot.docs.forEach(
            (doc) => {
              _firestore
                  .collection('users')
                  .doc(currentUser.uid)
                  .collection('saved')
                  .doc(doc.id)
                  .delete()
            },
          )
        },
      );
}
