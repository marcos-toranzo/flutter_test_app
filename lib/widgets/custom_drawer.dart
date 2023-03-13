import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_screen.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/language_info.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_dropdown_menu.dart';
import 'package:flutter_test_app/widgets/horizontally_scrollable_text.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';

class ModuleTile {
  final String title;
  final String path;

  ModuleTile({required this.title, required this.path});
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
  });

  final AuthController _authController = Get.find();
  final AppConfigurationController _appConfigurationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
            child: ColumnWithPadding(
              padding: const EdgeInsets.all(20),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizontallyScrollableText(
                  _authController.user?.username ?? '',
                  style: TextStyle(
                    fontSize: 28,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                HorizontallyScrollableText(
                  _authController.user?.email ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          _DrawerSectionHeader(title: translations.settings),
          _DrawerSectionElement(
            title: translations.language,
            trailing: CustomDropdownMenu(
              value: _appConfigurationController.selectedLocale?.languageCode ??
                  getCurrentLanguageCode(context),
              onChanged: (value) async {
                if (value != null) {
                  await _appConfigurationController.changeLocale(
                    Locale(value),
                  );
                }
              },
              items: Localization.supportedLocales.mapList(
                (locale) {
                  final languageInfo = languageInfoMap[locale.languageCode];

                  return CustomDropdownMenuElement(
                    value: locale.languageCode,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: languageInfo?.flag ?? const Icon(Icons.help),
                    ),
                    text: languageInfo?.name ?? locale.languageCode,
                  );
                },
              ),
            ),
          ),
          _DrawerSectionElement(
            title: translations.theme,
            trailing: Obx(
              () => CustomDropdownMenu(
                value: _appConfigurationController.appThemeMode,
                onChanged: (value) async {
                  if (value != null) {
                    _appConfigurationController.changeThemeMode(value);
                  }
                },
                items: [
                  CustomDropdownMenuElement(
                    value: ThemeMode.light,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/light.png'),
                    ),
                    text: translations.light,
                  ),
                  CustomDropdownMenuElement(
                    value: ThemeMode.dark,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/dark.png'),
                    ),
                    text: translations.dark,
                  ),
                  CustomDropdownMenuElement(
                    value: ThemeMode.system,
                    icon: const Icon(
                      FontAwesomeIcons.mobileScreen,
                      size: 20,
                    ),
                    text: translations.system,
                  ),
                ],
              ),
            ),
          ),
          const _DrawerSectionSeparator(),
          _DrawerSectionElement(
            title: translations.signOut,
            trailing: Icon(
              Icons.logout,
              color: Colors.red.shade700,
            ),
            onTap: () {
              _authController.logout(
                onLogOut: () {
                  routingService.popAllAndPushRoute(
                    context: context,
                    routeName: LoginSignUpScreen.routeName,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerSectionSeparator extends StatelessWidget {
  const _DrawerSectionSeparator();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.1,
      indent: 10,
      endIndent: 10,
    );
  }
}

class _DrawerSectionElement extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _DrawerSectionElement({
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 10),
      title: OnBackgroundText(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _DrawerSectionHeader extends StatelessWidget {
  final String title;

  const _DrawerSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return RowWithPadding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 4),
      children: [
        OnBackgroundText(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Expanded(
          child: _DrawerSectionSeparator(),
        ),
      ],
    );
  }
}
