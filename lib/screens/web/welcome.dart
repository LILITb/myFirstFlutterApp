import 'package:flutter/material.dart';
import '../../classes/language.dart';
import '../../localization/language_constants.dart';
import '../../main.dart';
import 'components/app_bar_for_web.dart';
import 'components/login_body.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeWeb extends StatefulWidget {
  const WelcomeWeb({Key? key}) : super(key: key);

  @override
  State<WelcomeWeb> createState() => _WelcomeWebState();
}

class _WelcomeWebState extends State<WelcomeWeb> {
  String flag = "🇺🇸";
  String name = "English";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // get passing datas
    final Map<String, Object> passingData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    // Future<String> getLanguageCode(BuildContext context) async {
    //   if (Localizations.localeOf(context).languageCode == null) {
    //     return Language(1, "🇺🇸", "English", "en").languageCode;
    //   } else {
    //     return Localizations.localeOf(context).languageCode;
    //   }
    // }

    // Future<String> LanguageCode = getLanguageCode(context);

    void _changeLanguage(Language language) async {
      flag = language.flag;
      name = language.name;

      Locale _locale = await setLocale(language.languageCode);

      MyApp.setLocale(context, _locale);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarForWeb(size: size),
      body: SingleChildScrollView(
        child: Center(child: Text('Welcome ${passingData["userInfo"]}')),
      ),
    );
  }
}
