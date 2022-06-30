import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/utils/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ServiceApiAccount {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore firebasestore = FirebaseFirestore.instance;
  final FirebaseStorage firebasestorege = FirebaseStorage.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();
  final FacebookAuth facebookignin = FacebookAuth.instance;

  final String _profile = "Profile";
  final String _email = "email";
  final String _fullname = "fullname";
  final String _imgUrl = "imgUrl";
  final String _status = "status";
  final String _user = "User";
  final String _admin = "Admin";
  final String _username = "username";

  Future<User> getUser() async {
    final user = firebaseauth.currentUser!;

    return user;
  }

  Future<String> emailSignIn(String email, String password) async {
    final respons = await firebaseauth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseauth.currentUser;

    if (respons) {
      if (userCheck != null) {
        return "Sign In Email Success";
      } else {
        await emailSignOut();
        throw FirebaseDataException("Failed Email Sign In");
      }
    } else {
      await emailSignOut();
      throw FirebaseException(plugin: "Invalid Password");
    }
  }

  Future<String> emailSignOut() async {
    final respons = await firebaseauth
        .signOut()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseauth.currentUser;

    if (respons) {
      if (userCheck == null) {
        return "Sign Out Email Success";
      } else {
        throw FirebaseDataException("User is not Recognized");
      }
    } else {
      throw FirebaseException(plugin: "Failed Email Sign Out");
    }
  }

  Future<String> deleteAuth() async {
    final userCheck = firebaseauth.currentUser;
    final respons = await userCheck!
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck2 = firebaseauth.currentUser;
    if (respons) {
      if (userCheck2 == null) {
        return "Delete Auth Success";
      } else {
        throw FirebaseDataException("User is not Recognized");
      }
    } else {
      throw FirebaseException(plugin: "Failed Email Sign Out");
    }
  }

  Future<String> emailSignUp(String email, String password) async {
    final respons = await firebaseauth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseauth.currentUser;

    if (respons) {
      if (userCheck != null) {
        return "Sign Up Email Success";
      } else {
        await emailSignOut();
        throw FirebaseDataException("User can't Registered");
      }
    } else {
      throw FirebaseException(plugin: "Failed Email Sign Up");
    }
  }

  Future<String> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await googlesignin.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await firebaseauth.signInWithCredential(credential);
    final User user = authResult.user!;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);

    if (authResult.user?.email != null ||
        user.displayName != null ||
        !user.isAnonymous) {
      if (currentUser.email == authResult.user?.email) {
        return "Sign In And Up Google Success";
      } else {
        throw FirebaseDataException("User can't Sign In and Up with Google");
      }
    } else {
      throw FirebaseException(plugin: "Failed Google Sign Up and Sign In");
    }
  }

  Future<String> googleSignUp() async {
    final GoogleSignInAccount? googleUser = await googlesignin.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await firebaseauth.signInWithCredential(credential);
    final User user = authResult.user!;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);

    if (authResult.user?.email != null ||
        user.displayName != null ||
        !user.isAnonymous) {
      if (currentUser.email == authResult.user?.email) {
        return "Sign In And Up Google Success";
      } else {
        throw FirebaseDataException("User can't Sign In and Up with Google");
      }
    } else {
      throw FirebaseException(plugin: "Failed Google Sign Up and Sign In");
    }
  }

  Future<String> googleSignOut() async {
    final respons = await googlesignin
        .signOut()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseauth.currentUser;

    if (respons) {
      if (userCheck == null) {
        return "Sign Out Google Success";
      } else {
        throw FirebaseDataException("User can't Sign Out Google");
      }
    } else {
      throw FirebaseException(plugin: "Failed Google Out");
    }
  }

  Future<String> facebookSignOut() async {
    final respons = await facebookignin
        .logOut()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseauth.currentUser;

    if (respons) {
      if (userCheck == null) {
        return "Sign Out Facebook Success";
      } else {
        throw FirebaseDataException("User can't Sign Out with Facebook");
      }
    } else {
      throw FirebaseException(plugin: "Failed Facebook Out");
    }
  }

  Future<String> facebookSignIn() async {
    final LoginResult result = await facebookignin.login();
    final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    final userCredential =
        await firebaseauth.signInWithCredential(facebookCredential);

    final userCheck = firebaseauth.currentUser;

    if (userCredential.user?.email != null || userCheck!.email != null) {
      if (userCheck!.email == userCredential.user?.email) {
        return "Sign In And Up Facebook Success";
      } else {
        throw FirebaseDataException("User can't Sign In and Up with Facebook");
      }
    } else {
      throw FirebaseException(plugin: "Failed Facebook Sign Up and Sign In");
    }
  }

  Future<String> facebookSignUp() async {
    final LoginResult result = await facebookignin.login();
    final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    final userCredential =
        await firebaseauth.signInWithCredential(facebookCredential);

    final userCheck = firebaseauth.currentUser;

    if (userCredential.user?.email != null || userCheck!.email != null) {
      if (userCheck!.email == userCredential.user?.email) {
        return "Sign In And Up Facebook Success";
      } else {
        throw FirebaseDataException("User can't Sign In and Up with Facebook");
      }
    } else {
      throw FirebaseException(plugin: "Failed Facebook Sign Up and Sign In");
    }
  }

  Future<String> registerProfile(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  ) async {
    final userCheck = firebaseauth.currentUser;

    final checkProfile = await isHaveProfile(userCheck!.email ?? "");

    if (userCheck.email == email) {
      if (!checkProfile) {
        final respons = await firebasestore.runTransaction(
          (transaction) async {
            CollectionReference reference = firebasestore.collection(_profile);
            Reference ref = firebasestorege
                .ref()
                .child(imageName + DateTime.now().toString());
            UploadTask uploadTask = ref.putFile(image);

            final respons = await uploadTask.then(
              (res) async {
                String urlName = await res.ref.getDownloadURL();
                await reference.add({
                  _email: email,
                  _username: username,
                  _fullname: fullname,
                  _imgUrl: urlName,
                  _status: _user,
                });
                return true;
              },
            ).onError((error, stackTrace) => false);

            return respons;
          },
        );

        if (respons) {
          return "Register Profile Success";
        } else {
          throw FirebaseException(plugin: "Failed Register Profile");
        }
      } else {
        throw FirebaseException(plugin: "You Already Have A Profile");
      }
    } else {
      throw FirebaseException(plugin: "You Did'n Have Permision To Register");
    }
  }

  Future<String> editProfile(
    String usernameNow,
    String fullnameNow,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  ) async {
    final userCheck = firebaseauth.currentUser;

    final checkProfile = await isHaveProfile(userCheck!.email ?? "");

    if (userCheck.email != null) {
      if (checkProfile) {
        final respons = await firebasestore.runTransaction(
          (transaction) async {
            CollectionReference reference = firebasestore.collection(_profile);
            UploadTask? uploadTask;
            if (image != null) {
              Reference ref = firebasestorege
                  .ref()
                  .child(imageName! + DateTime.now().toString());
              uploadTask = ref.putFile(image);
              final resp = await uploadTask
                  .then(
                    (res) async {
                      firebasestorege.refFromURL(urlNameNow).delete();
                      urlNameNow = await res.ref.getDownloadURL();
                      await reference.doc(index.id).update({
                        _username: usernameNow,
                        _fullname: fullnameNow,
                        _imgUrl: urlNameNow,
                      });
                    },
                  )
                  .then((value) => true)
                  .onError((error, stackTrace) => false);
              return resp;
            } else {
              uploadTask = null;
              final resp = await reference
                  .doc(index.id)
                  .update({
                    _username: usernameNow,
                    _fullname: fullnameNow,
                    _imgUrl: urlNameNow,
                  })
                  .then((value) => true)
                  .onError((error, stackTrace) => false);
              return resp;
            }
          },
        );

        if (respons) {
          return "Edit Profile Success";
        } else {
          throw FirebaseException(plugin: "Failed Edit Profile");
        }
      } else {
        throw FirebaseException(plugin: "You Did'n Have Permision To Edit");
      }
    } else {
      throw FirebaseException(plugin: "You Did'n Have Profile");
    }
  }

  Future<bool> isHaveProfile(String email) async {
    final respons = await firebasestore
        .collection(_profile)
        .where(_email, isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isEmpty || value.docs.length > 1) {
        return false;
      } else {
        return true;
      }
    });

    return respons;
  }

  Future<bool> isAdmin(String email) async {
    final respons = await firebasestore
        .collection(_profile)
        .where(_email, isEqualTo: email)
        .where(_status, isEqualTo: _admin)
        .get()
        .then((value) {
      if (value.docs.isEmpty || value.docs.length > 1) {
        return false;
      } else {
        return true;
      }
    });

    return respons;
  }
}
