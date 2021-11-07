import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';

class StartupViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future<void> init() async {
    WidgetsBinding.instance!.addPostFrameCallback((Duration duration) async {
      Timer(
        Duration(
          seconds: 3,
        ),
        () async => await navigateToHomeView(),
      );
    });
  }

  Future navigateToHomeView() async {
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snap['interests'].toString().isEmpty) {
        await _routerService.router.push(
          HomeRoute(),
        );
      } else {
        await _routerService.router.push(
          BottomNav(),
        );
      }
    } else {
      await _routerService.router.push(
        HomeRoute(),
      );
    }
  }
}
