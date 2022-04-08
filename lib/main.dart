import 'package:flutter/material.dart';
import 'classes/language.dart';
import 'localization/demo_localization.dart';
import 'responsive.dart';
import 'constants.dart';
import 'screens/web/verification.dart';

import 'screens/web/create_account.dart';
import 'screens/web/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/language_constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? st = context.findAncestorStateOfType<_MyAppState>();
    _MyAppState state = (st as _MyAppState);
    state.setLocale(newLocale);
  }

  static getFlagAndLanguage() {
    getLocale().then((locale) {
      Language.languageList().map((lang) {
        if (lang.languageCode == locale.languageCode) {
          return {'flag': lang.flag, 'name': lang.name};
        }
      });

      return null;
    });
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HyeId',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Assistant',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  // color: Colors.blue,
                  color: Color.fromRGBO(59, 158, 146, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(59, 158, 146, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 24,
                  //fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
        locale: _locale,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('hy', 'AM'),
          Locale('ru', 'RU')
        ],
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (locale != null) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        home: const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Responsive(
              web: LoginScreenWeb(),
              android: LoginScreenWeb(),
              ios: LoginScreenWeb(),
              smallWeb: LoginScreenWeb()),
        ),
        routes: {
          '/create-account': (ctx) => const CreateAccountWeb(),
          '/verification': (ctx) => const VerificationScreenWeb(),
        },
      );
    }
  }
}
