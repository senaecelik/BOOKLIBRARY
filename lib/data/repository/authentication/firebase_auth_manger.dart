import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/data/repository/authentication/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthManager extends AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthManager(this._auth);

  User get user => _auth.currentUser!;

  //STATE PERSISTENCE
  @override
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //EMAIL SIGN UP

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // await sendEmailVerification();
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }catch(e) {
      rethrow;
    }
  }

  //EMAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser!.sendEmailVerification();
      // showSnackBar(context: context, text: "Email verification sent");
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }catch(e) {
      rethrow;
    }
  }

  //GOOGLE SIGN IN
  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      if (googleSignInAuthentication?.accessToken != null &&
          googleSignInAuthentication?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication?.accessToken,
            idToken: googleSignInAuthentication?.idToken);
        // UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // if(userCredential.user !=null){
        //   if(userCredential.additionalUserInfo!.isNewUser){

        //   }
        // }
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //PHONE SIGN IN

  @override
  Future<void> phoneSignIn(String phoneNumber) async {
    // TextEditingController codeController = TextEditingController();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw e;
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          // showOTPDialog(
          //   context: context,
          //   codeController: codeController,
          //   onPressed: () async {
          //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //       verificationId: verificationId,
          //       smsCode: codeController.text.trim(),
          //     );

          //     await _auth.signInWithCredential(credential);
          //     Navigator.pop(context);
          //   },
          // );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          //Auto-resolution timed out..
        },
      );
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }
  }

  //EMAIL LOGIN
  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if (!_auth.currentUser!.emailVerified) {
      //   await sendEmailVerification();
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthenticationException(
            'Lütfen geçerli bir e-posta adresi giriniz');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationException('Yanlış şifre, lütfen tekrar dene');
      } else if (e.code == 'user-not-found') {
        throw AuthenticationException('Kayıtlı e-posta adresi bulunamadı');
      } else if (e.code == 'user-disabled') {
        throw AuthenticationException('Böyle bir kullanıcı kaydı bulunamadı');
      } else if (e.code == 'operation-not-allowed') {
        throw AuthenticationException('Böyle bir kullanıcı kaydı bulunamadı');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthenticationException("Böyle bir kullanıcı kaydı bulunamadı ");
      } else {
        throw AuthenticationException("Something error");
      }
    } catch (e) {
      rethrow;
    }
  }

  //ANONYMOUS SIGN IN

  @override
  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException {
      rethrow;

      // showSnackBar(context: context, text: e.message!);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }
  }

  //SIGN OUT
  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }
  }

  //DELETE
  @override
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException {
      rethrow;
      // showSnackBar(context: context, text: e.message!);
    }
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() {
    return '$message';
  }
}
