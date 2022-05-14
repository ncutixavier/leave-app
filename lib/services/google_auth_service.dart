import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  late GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;
  AccessToken? accessToken;

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final response = FirebaseAuth.instance.currentUser;
    print('USER-${response?.displayName}');
    return response;
  }

  Future facebookAuth() async{
    final LoginResult result = await FacebookAuth.i.login();
    if(result.status == LoginStatus.success){
      accessToken = result.accessToken;

      final response = await FacebookAuth.i.getUserData();
      print("USER-FB:: $response");
      return response;
    }
  }

  Future logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}