import 'package:flutter/material.dart';
import '../../classes/language.dart';
import '../../localization/language_constants.dart';
import '../../main.dart';
import 'components/app_bar_for_web.dart';
import 'components/create_account_body.dart';

class CreateAccountWeb extends StatefulWidget {
  const CreateAccountWeb({Key? key}) : super(key: key);

  @override
  State<CreateAccountWeb> createState() => _CreateAccountWebState();
}

class _CreateAccountWebState extends State<CreateAccountWeb> {
  String flag = "🇺🇸";
  String name = "English";

  void _changeLanguage(Language language) async {
    flag = language.flag;
    name = language.name;

    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final args =
    //     (ModalRoute.of(context)!.settings.arguments as ScreenArguments);
    // print('passed values ${args.choosenLocale.toString()}');
    //MyApp.setLocale(context, widget.locale);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarForWeb(size: size),
      body: const SingleChildScrollView(
        child: DesktopCreateAccountBody(),
      ),
    );
  }
}
