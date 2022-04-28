// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ruta no encontrada`
  String get noRouteFound {
    return Intl.message(
      'Ruta no encontrada',
      name: 'noRouteFound',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get close {
    return Intl.message(
      'Cerrar',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get confirm {
    return Intl.message(
      'Confirmar',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Volver a intentarlo`
  String get retryAgain {
    return Intl.message(
      'Volver a intentarlo',
      name: 'retryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Cargando...`
  String get loading {
    return Intl.message(
      'Cargando...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Correo enviado`
  String get sendEmail {
    return Intl.message(
      'Correo enviado',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get accept {
    return Intl.message(
      'Aceptar',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Éxito`
  String get success {
    return Intl.message(
      'Éxito',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Correo`
  String get inputEmail {
    return Intl.message(
      'Correo',
      name: 'inputEmail',
      desc: '',
      args: [],
    );
  }

  /// `Correo error`
  String get inputEmailError {
    return Intl.message(
      'Correo error',
      name: 'inputEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get inputPassword {
    return Intl.message(
      'Contraseña',
      name: 'inputPassword',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get login {
    return Intl.message(
      'Ingresar',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `No tiene permisos`
  String get notPermission {
    return Intl.message(
      'No tiene permisos',
      name: 'notPermission',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar`
  String get recover {
    return Intl.message(
      'Recuperar',
      name: 'recover',
      desc: '',
      args: [],
    );
  }

  /// `Has olvidado tu cotraseña`
  String get forgotPassword {
    return Intl.message(
      'Has olvidado tu cotraseña',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
