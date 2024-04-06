import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/theme/app_theme_provider.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/data/repository/authentication/firebase_auth_manger.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/presentation/home/search_isbn/search_isbn_screen.dart';
import 'package:flutter_project/resources/values_manager.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  late bool showNavigationDrawer;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final firebaseUser = context.watch<User?>();

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // leading: IconButton(
        //     style: IconButton.styleFrom(
        //         backgroundColor: Theme.of(context).splashColor),
        //     onPressed: () {
        //       if (scaffoldKey.currentState!.isDrawerOpen) {
        //         scaffoldKey.currentState!.closeDrawer();
        //       } else {
        //         scaffoldKey.currentState!.openDrawer();
        //       }
        //     },
        //     icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: CircleAvatar(
                backgroundColor: Theme.of(context).splashColor,
                child: firebaseUser!.photoURL != null
                    ? Image.network(firebaseUser!.photoURL!)
                    : const Icon(Icons.person_outline)),
          )
        ],
        centerTitle: true,
        title: Text(LocaleKeys.home_title.tr()),
      ),
      drawer: NavigationDrawer(
          onDestinationSelected: (value) {
            setState(() {
              screenIndex = value;
            });

            switch (value) {
              case 3:
                context.read<AppThemeProvider>().themeMode == ThemeMode.dark
                    ? context.read<AppThemeProvider>().setTheme(ThemeMode.light)
                    : context.read<AppThemeProvider>().setTheme(ThemeMode.dark);
              case 4:
                context.read<FirebaseAuthManager>().signOut();
                context.router.pushAndPopUntil(
                  const SplashRoute(),
                  predicate: (route) => false,
                );
                break;
              default:
            }
            if (value == 3) {
            } else {}
          },
          selectedIndex: screenIndex,
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
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchIsbnScreen(),));

        },
        child: const Icon(Icons.pending),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Roadmap',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.search),
          //   icon: Icon(Icons.search_outlined),
          //   label: 'Explore',
          // ),
        ],
      ),
      body: <Widget>[
        /// Home page
        _home(context),

        const Text("data"),
      ][currentPageIndex],
    );
  }

  Widget _home(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppPadding.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   " Hoşgeldin,\n" " ${firebaseUser!.email}",
              //   style: Theme.of(context).textTheme.headlineSmall,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * .30,
                margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SizedBox(
                      child: AppCard(
                          onTap: () {},
                          titleTextStyle:
                              Theme.of(context).textTheme.headlineSmall,
                          title: "Roadmap with Gemini",
                          leading: const Icon(Icons.messenger_outline_outlined),
                          trailing: const Icon(Icons.arrow_outward_outlined),
                          cardColor: Theme.of(context).colorScheme.background),
                    )),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .150,
                            child: AppCard(
                                onTap: () {},
                                title: "Explore Other Roadmap",
                                leading: const Icon(Icons.explore_outlined),
                                trailing: const Icon(Icons.arrow_outward_outlined),
                                cardColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .150,
                            child: AppCard(
                                onTap: () {},
                                title: "My Roadmap Schedule",
                                leading: const Icon(Icons.calendar_today_outlined),
                                trailing: const Icon(Icons.arrow_outward_outlined),
                                cardColor: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text("Topics"),
          trailing: TextButton(onPressed: () {}, child: const Text("See all")),
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.code,
                        ),
                        padding: EdgeInsets.all(AppPadding.p20),
                      ),
                      SizedBox(
                        height: AppSizeHeight.s12,
                      ),
                      const Text("Code")
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    this.titleTextStyle,
    this.cardColor,
    this.onTap,
  });

  final String title;
  final Widget leading;
  final Widget trailing;
  final TextStyle? titleTextStyle;
  final Color? cardColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                leading: CircleAvatar(
                    backgroundColor: Theme.of(context).splashColor,
                    child: leading),
                trailing: trailing,
              ),
              ListTile(
                title: Text(
                  title,
                ),
                titleTextStyle:
                    titleTextStyle ?? Theme.of(context).textTheme.labelLarge,
              )
            ],
          )),
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'Messages', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  ExampleDestination(
      'Profile', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  ExampleDestination(
      'Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
  ExampleDestination('Tema', Icon(Icons.light_outlined), Icon(Icons.light)),
  ExampleDestination('Logout', Icon(Icons.logout_outlined), Icon(Icons.logout)),
];
