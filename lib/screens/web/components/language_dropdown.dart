import 'package:flutter/material.dart';
import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    String flag = "🇺🇸";
    String name = "English";

    // void getCurrentLocale() async {
    //   getLocale().then((locale) {
    //     setState(() {
    //       Language.languageList().map((lang) {
    //         if (lang.languageCode == locale.languageCode) {
    //           print('in');
    //           flag = lang.flag;
    //           name = lang.name;
    //         }
    //       });
    //     });
    //   });
    // }
    //print(MyApp.getFlagAndLanguage());

    //Locale currentLocale =await  getLocale();

    void _changeLanguage(Language language) async {
      flag = language.flag;
      name = language.name;

      Locale _locale = await setLocale(language.languageCode);

      MyApp.setLocale(context, _locale);

      // print(name);
      // print(flag);
    }

    return DropdownButton(
      style: const TextStyle(
        fontSize: 14,
        height: 1.8,
      ),
      onChanged: (Language? language) async {
        _changeLanguage(language!);

        print(flag);
        print(name);
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
    );
  }
}
