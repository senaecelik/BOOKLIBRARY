import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<ResponseModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return ResponseModel(
          user: userCredential.user,
          errorMessage: "Successfull"); // Giriş başarılı olduğunda null döner
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            return ResponseModel(
                errorMessage:
                    'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.');
          case 'user-disabled':
            return ResponseModel(
                errorMessage:
                    'Kullanıcı devre dışı bırakıldı. Lütfen destek ekibiyle iletişime geçin.');
          case 'user-not-found':
            return ResponseModel(
                errorMessage:
                    'Kullanıcı bulunamadı. Lütfen kayıtlı bir e-posta adresi girin.');
          case 'wrong-password':
            return ResponseModel(
                errorMessage:
                    'Yanlış şifre. Lütfen şifrenizi kontrol edin ve tekrar deneyin.');
          case 'too-many-requests':
            return ResponseModel(
                errorMessage:
                    'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.');
          case 'network-request-failed':
            return ResponseModel(
                errorMessage:
                    'Ağ hatası. Lütfen internet bağlantınızı kontrol edin.');
          default:
            return ResponseModel(
                errorMessage: 'Bilinmeyen bir hata oluştu: ${e.code}');
        }
      } else {
        // FirebaseAuthException dışındaki hatalar için genel hata mesajı dön
        return ResponseModel(errorMessage: e.toString());
      }
    }
  }

  Future<ResponseModel?> createUserWithEmailAndPassword(
      String userName, String email, String password) async {
    try {
      // Kullanıcı hesabı oluşturma
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Kullanıcı bilgilerini Firestore'a kaydetme
        if (userCredential.additionalUserInfo!.isNewUser) {
          await addUserCollection(userCredential, userName, email);
        }
      }

      // Yeni kullanıcı hesabı oluşturuldu
      return ResponseModel(
          user: userCredential.user, errorMessage: "Successfull");
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            return ResponseModel(
                errorMessage:
                    'Bu e-posta adresi zaten kullanımda. Lütfen farklı bir e-posta adresi deneyin.');
          case 'invalid-email':
            return ResponseModel(
                errorMessage:
                    'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.');
          case 'weak-password':
            return ResponseModel(
                errorMessage:
                    'Şifre zayıf. Şifreniz en az 6 karakterden oluşmalıdır.');
          case 'user-not-found':
            return ResponseModel(
                errorMessage:
                    'Kullanıcı bulunamadı. Lütfen kayıtlı bir e-posta adresi girin.');
          case 'wrong-password':
            return ResponseModel(
                errorMessage:
                    'Yanlış şifre. Lütfen şifrenizi kontrol edin ve tekrar deneyin.');
          case 'too-many-requests':
            return ResponseModel(
                errorMessage:
                    'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.');
          case 'network-request-failed':
            return ResponseModel(
                errorMessage:
                    'Ağ hatası. Lütfen internet bağlantınızı kontrol edin.');
          default:
            return ResponseModel(
                errorMessage: 'Lütfen daha sonra tekrar deneyin.');
        }
      } else {
        return ResponseModel(errorMessage: e.toString());
      }
    }
  }

  Future<void> addUserCollection(UserCredential userCredential, String userName, String email) async {
     await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'name': userName,
      'email': email,
      // Diğer kullanıcı bilgileri buraya eklenir...
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      return "E-posta adresinize şifrenizi sıfırlamanız için bir bağlantı gönderildi.";
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            return "Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi giriniz.";
          case 'user-not-found':
            return "Bu e-posta adresiyle ilişkilendirilmiş bir hesap bulunamadı.";
          case 'too-many-requests':
            return "Çok fazla şifre sıfırlama isteği yapıldı. Lütfen daha sonra tekrar deneyin.";
          default:
            return "Şifre sıfırlama e-postası gönderilirken bir hata oluştu: ${e.message}";
        }
      } else {
        return "Şifre sıfırlama e-postası gönderilirken bir hata oluştu: $e";
      }
    }
  }

  
  Future<ResponseModel?> signInWithGoogle() async {
    try {
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

       await _firebaseAuth.signInWithCredential(credential);
      
      
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Stream<User?> getAuthStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}

class ResponseModel {
  final User? user;
  final String? errorMessage;

  ResponseModel({this.user, this.errorMessage});
}
