import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/app/theme/app_theme_provider.dart';
import 'package:flutter_project/features/auth/presentation/cubit/auth/auth_cubit.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) {
        setState(() {
          selectedIndex = value;
        });
        switch (value) {
          case 0:
            // Tema değiştirme işlemini yap
            context.read<AppThemeProvider>().themeMode == ThemeMode.dark
                ? context.read<AppThemeProvider>().setTheme(ThemeMode.light)
                : context.read<AppThemeProvider>().setTheme(ThemeMode.dark);
            break;
          case 1:
            _buildSignOut(context);

            break;
          default:
        }
      },
      selectedIndex: selectedIndex,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Header',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...destinations.map(
          (ExampleDestination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
      ],
    );
  }

  Future<dynamic> _buildSignOut(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Hesabından çıkış yap?"),
          actions: [
            CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).loggedOut();
                  _navigateToSplashScreen(context);
                },
                child: const Text("Evet")),
            CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: () {
                  context.router.maybePop();
                },
                child: const Text("İptal")),
          ],
        );
      },
    );
  }

  Future<dynamic> _showSignOutErrorDialog(
    BuildContext context,
  ) {
    return showAdaptiveDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Uyarı"),
              content: const Text("Lütfen tekrar deneyiniz.\n"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      context.router.maybePop();
                    },
                    child: const Text("Tamam")),
              ],
            ));
  }

  Future<Object?> _navigateToSplashScreen(BuildContext context) {
    return context.router.pushAndPopUntil(
      const WelcomeRoute(),
      predicate: (route) => false,
    );
  }
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  // ExampleDestination(
  //     'Messages', Icon(Icons.widgets_outlined),
  //        Icon(Icons.widgets)),
  // ExampleDestination(
  //     'Profile', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  // ExampleDestination(
  //     'Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
  ExampleDestination(
      label: 'Tema',
      icon: Icon(Icons.light_outlined),
      selectedIcon: Icon(Icons.light)),
  ExampleDestination(
      label: 'Logout',
      icon: Icon(Icons.logout_outlined),
      selectedIcon: Icon(Icons.logout)),
];

class ExampleDestination {
  const ExampleDestination(
      {required this.label, required this.icon, required this.selectedIcon});

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}
