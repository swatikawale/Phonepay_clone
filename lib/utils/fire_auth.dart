import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final storage = FlutterSecureStorage();

class FireAuth {
  // For registering a new user
  static Future<User> registerUsingEmailPassword({
     String name,
     String email,
     String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  // For signing in an user (have already registered)
  static Future<bool> signInUsingEmailPassword({
     String email,
     String password,
  }) async {
     if( email!="admin@gmail.com" || password!="Admin123"  ){
    
        print('Wrong password provided.');
        return false;
      }
      
    
await storage.write(key: "email",value:email);
await storage.write(key: "pass",value:password);
    return true;
  }

  static Future<User> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
