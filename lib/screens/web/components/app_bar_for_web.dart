import 'package:flutter/material.dart';
import '../../../localization/language_constants.dart';
import 'language_dropdown.dart';

class AppBarForWeb extends StatelessWidget implements PreferredSizeWidget {
  const AppBarForWeb({Key? key, required this.size})
      : preferredSize = const Size.fromHeight(120.0);
  final Size size;
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                  onTap: () {},
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
                child: const LanguageDropdown(),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: const Color.fromRGBO(254, 254, 253, 1),
    );
  }
}
