import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_task/core/exeptions/exeptions.dart';
import 'package:social_task/core/secure_storage/secure_storage_helper.dart' show SecureStorageHelper;
import 'package:social_task/core/services/service.dart';
import 'package:social_task/features/auth/data/models/user_model.dart';

abstract class AuthBaseRemoteDataSource {
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthBaseRemoteDataSource {
  final SecureStorageHelper secureStorageHelper;
  final FirebaseAuth firebaseAuth;
  final dynamic googleSignIn;
  final fb.FacebookAuth facebookAuth;

  AuthRemoteDataSourceImpl({
    required this.secureStorageHelper,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.facebookAuth,
  });

  @override

Future<UserModel> loginWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = sl<GoogleSignIn>();

    await googleSignIn.initialize(
      clientId: '728895104988-ahmmv5cqfei7uqsu4j59mcsoo6ruidh5.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

    if (googleUser == null) {
      throw ExceptionWithMessage(message: 'Google login cancelled.');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user!;

    await secureStorageHelper.assignData(key: 'user_id', value: user.uid);

    return UserModel.fromFirebaseUser(
      user.uid,
      user.displayName ?? 'Google User',
      user.email ?? '',
    );
  } on FirebaseAuthException catch (e) {
    throw ServerException();
  } catch (e) {
    print('Google login error: $e');
    throw UnknownException();
  }
}

  @override
  Future<UserModel> loginWithFacebook() async {
    try {
      final fb.LoginResult result = await facebookAuth.login();
      
      if (result.status == fb.LoginStatus.success) {
        final fb.AccessToken? accessToken = result.accessToken;
        final tokenString = (accessToken as dynamic)?.token ?? (accessToken as dynamic)?.accessToken;
        if (tokenString == null || tokenString.isEmpty) {
          throw ExceptionWithMessage(message: 'Facebook token is null.');
        }

        final OAuthCredential credential = FacebookAuthProvider.credential(tokenString);
        
        final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user!;
        
        await secureStorageHelper.assignData(key: 'user_id', value: user.uid);

        return UserModel.fromFirebaseUser(
          user.uid,
          user.displayName ?? 'Facebook User',
          user.email ?? '',
        );
      } else if (result.status == fb.LoginStatus.cancelled) {
        throw ExceptionWithMessage(message: 'Facebook login cancelled.');
      } else {
        throw ExceptionWithMessage(message: 'Facebook login failed.');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException();
    } catch (e) {
      throw UnknownException();
    }
  }
  
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    try {
      await googleSignIn.signOut();
    } catch (_) {}
    try {
      await facebookAuth.logOut();
    } catch (_) {}
    await secureStorageHelper.deleteData(key: 'user_id');
  }
}