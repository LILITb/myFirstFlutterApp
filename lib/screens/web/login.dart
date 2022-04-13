import 'package:flutter/material.dart';
import '../../classes/language.dart';
import '../../localization/language_constants.dart';
import '../../main.dart';
import 'components/login_body.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreenWeb extends StatefulWidget {
  const LoginScreenWeb({Key? key}) : super(key: key);

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb> {
  String flag = "🇺🇸";
  String name = "English";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      appBar: AppBar(
        toolbarHeight: 120,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 33, 73, 33),
            height: 48,
            child: Row(
              children: [
                Material(
                  color: const Color.fromRGBO(250, 250, 247, 1),
                  elevation: 4,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: InkWell(
                    splashColor: Colors.black26,
                    onTap: () => launch(
                        'https://development.connectto.com/hyeid-stage/auth/login?returnUrl=%2F'),
                    child: Row(
                      children: [
                        Ink.image(
                          image: const AssetImage(
                            "assets/images/logo_small.png",
                          ),
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          getTranslated(context, 'hyeid_website'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(34, 33, 32, 1),
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                    border: Border.all(
                      color: const Color.fromRGBO(34, 33, 32, 0.1),
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: const Color.fromRGBO(250, 250, 247, 1),
                  ),
                  child: DropdownButton(
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                    ),
                    onChanged: (Language? language) async {
                      _changeLanguage(language!);
                    },
                    underline: SizedBox(),
                    hint: Container(
                      width: 135,
                      height: 80,
                      child: Row(
                        children: [
                          Text(
                            flag,
                            style: const TextStyle(
                                color: Color.fromRGBO(34, 33, 32, 0.7),
                                fontSize: 14,
                                height: 1.2),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                color: Color.fromRGBO(34, 33, 32, 1),
                                fontSize: 16,
                                height: 1.6),
                          ),
                        ],
                      ),
                    ),
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    color: Color.fromRGBO(34, 33, 32, 0.7),
                                  ),
                                ),
                                Text(
                                  e.flag,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(34, 33, 32, 0.7),
                                      fontSize: 24,
                                      height: 1.2),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(254, 254, 253, 1),
      ),
      body: const SingleChildScrollView(
        child: DesktopLoginBody(),
      ),
    );
  }
}
