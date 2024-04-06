// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "welcome": {
    "continue_as_a_guest": "Continue as a guest"
  },
  "login": {
    "title": "Welcome back! Glad to see you, Again!",
    "forgot_pass": "Fotgot Password?",
    "or_login_with": "Or Login With",
    "dont_you_have_an_account": "Don't you have an account?",
    "register_now": "Register now"
  },
  "register": {
    "title": "Hello! Register to get started.",
    "or_resigter_with": "Or Register With",
    "have_an_account": "Have you an account?",
    "login_now": "Login Now"
  },
  "home": {
    "title": "Home"
  },
  "general": {
    "language": {
      "tr": "Turkish",
      "en": "English"
    },
    "text_field": {
      "email": {
        "label": "Email",
        "hint": "Please enter email"
      },
      "password": {
        "label": "Password",
        "hint": "Please enter password"
      }
    },
    "button": {
      "save": "Kaydet",
      "sign_in_with_google": "Sign in with Google",
      "login": "Giriş Yap",
      "register": "Kayıt Ol"
    },
    "snackbar": {
      "version": {
        "title": "Versiyon",
        "content": ""
      }
    }
  }
};
static const Map<String,dynamic> tr = {
  "welcome": {
    "continue_as_a_guest": "Misafir olarak devam et"
  },
  "login": {
    "title": "Tekrar hoş geldiniz! Sizi tekrar görmek güzel!",
    "forgot_pass": "Şifremi Unuttum?",
    "or_login_with": "Veya ile giriş yapın",
    "dont_you_have_an_account": "Hesabınız yok mu?",
    "register_now": "Şimdi kaydol"
  },
  "register": {
    "title": "Merhaba! Başlamak için kaydolun.",
    "or_resigter_with": "Veya ile kaydolun",
    "have_an_account": "Zaten bir hesabınız mı var?",
    "login_now": "Şimdi giriş yapın"
  },
  "home": {
    "title": "Anasayfa"
  },
  "general": {
    "language": {
      "tr": "Türkçe",
      "en": "İngilizce"
    },
    "text_field": {
      "email": {
        "label": "E-posta",
        "hint": "Lütfen e-postayı girin"
      },
      "password": {
        "label": "Şifre",
        "hint": "Lütfen şifreyi girin"
      }
    },
    "button": {
      "save": "Kaydet",
      "sign_in_with_google": "Google ile giriş yap",
      "login": "Giriş Yap",
      "register": "Kayıt Ol"
    },
    "snackbar": {
      "version": {
        "title": "Sürüm",
        "content": ""
      }
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "tr": tr};
}
