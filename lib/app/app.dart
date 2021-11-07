import 'package:brillo/app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:one_context/one_context.dart';

class BrilloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouterService _routerService = locator<RouterService>();
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: kWhite,
              body: Center(child: Text('App could not be launched')),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MatApp();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SpinKitChasingDots(
                color: kBlue,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MatApp extends StatelessWidget {
  const MatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterService _routerService = locator<RouterService>();
    return MaterialApp.router(
      builder: OneContext.instance.builder,
      debugShowCheckedModeBanner: false,
      title: "Brillo",
      routeInformationParser: _routerService.router.defaultRouteParser(),
      routerDelegate: _routerService.router.delegate(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}


// MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: "Brillo",
//       routeInformationParser: _routerService.router.defaultRouteParser(),
//       routerDelegate: _routerService.router.delegate(),
//       theme: ThemeData(
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//     );