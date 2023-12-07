import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify/config/app_router.dart';
import 'package:learnify/config/themes/styles.dart';
import 'package:learnify/firebase_options.dart';
import 'package:learnify/providers/auth_provider.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.themePreference.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
<<<<<<< HEAD
      child: MultiProvider(
        providers: [
          Provider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          StreamProvider(
            create: (context) => context.read<AuthProvider>().authState,
            initialData: null,
          ),
        ],
        child: GetMaterialApp.router(
          title: 'Project Management',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeChangeProvider.isDarkTheme, context),
          routerDelegate: AppRouter.appRouter.routerDelegate,
          routeInformationParser: AppRouter.appRouter.routeInformationParser,
          routeInformationProvider:
              AppRouter.appRouter.routeInformationProvider,
        ),
=======
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return GetMaterialApp.router(
            title: 'Project Management',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(
              themeChangeProvider.isDarkTheme,
              context,
            ),
            routerDelegate: AppRouter.appRouter.routerDelegate,
            routeInformationParser: AppRouter.appRouter.routeInformationParser,
            routeInformationProvider:
                AppRouter.appRouter.routeInformationProvider,
          );
        },
>>>>>>> att
      ),
    );

    // return StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.active) {
    //         if (snapshot.hasData) {
    //           return ChangeNotifierProvider(
    //             create: (_) {
    //               return themeChangeProvider;
    //             },
    //             child: Consumer<ThemeProvider>(
    //               builder: (context, value, child) {
    //                 return GetMaterialApp.router(
    //                   title: 'Project Management',
    //                   debugShowCheckedModeBanner: false,
    //                   theme: Styles.themeData(
    //                     themeChangeProvider.isDarkTheme,
    //                     context,
    //                   ),
    //                   routerDelegate: AppRouter.appRouter.routerDelegate,
    //                   routeInformationParser:
    //                       AppRouter.appRouter.routeInformationParser,
    //                   routeInformationProvider:
    //                       AppRouter.appRouter.routeInformationProvider,
    //                 );
    //               },
    //             ),
    //           );
    //         } else if (snapshot.hasError) {
    //           return Center(
    //             child: Text('${snapshot.error}'),
    //           );
    //         }
    //       }
    //     });
  }
}
