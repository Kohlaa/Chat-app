import 'package:chat/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toJson());
  }

  static Future<void> regesterUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }
  static Future<MyUser?> getUser(String userId) async{
   var documentSnapShot =await getUserCollection().doc(userId).get();
   documentSnapShot.data();
  }
}
