// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:brillo/ui/views/bottomNav/bottom.dart' as _i13;
import 'package:brillo/ui/views/change_email/change_email_view.dart' as _i10;
import 'package:brillo/ui/views/change_password/change_password_view.dart'
    as _i11;
import 'package:brillo/ui/views/forgot_password/forgot_password_view.dart'
    as _i14;
import 'package:brillo/ui/views/home/home_view.dart' as _i4;
import 'package:brillo/ui/views/login/login_view.dart' as _i6;
import 'package:brillo/ui/views/phone_auth/phone_auth_view.dart' as _i15;
import 'package:brillo/ui/views/phone_verify/phone_verify_view.dart' as _i7;
import 'package:brillo/ui/views/profile/profile_view.dart' as _i9;
import 'package:brillo/ui/views/signup/signup_view.dart' as _i5;
import 'package:brillo/ui/views/sports_type/sports_type_view.dart' as _i8;
import 'package:brillo/ui/views/startup/startup_view.dart' as _i3;
import 'package:brillo/ui/views/update_username/update_username_view.dart'
    as _i12;
import 'package:flutter/material.dart' as _i2;

class BrilloRouter extends _i1.RootStackRouter {
  BrilloRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartupRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.StartupView();
        }),
    HomeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomeView();
        }),
    SignupRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.SignupView();
        }),
    LoginRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.LoginView();
        }),
    PhoneVerifyRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.PhoneVerifyView();
        }),
    SportsTypeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.SportsTypeView();
        }),
    ProfileRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.ProfileView();
        }),
    ChangeEmailRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.ChangeEmailView();
        }),
    ChangePasswordRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.ChangePasswordView();
        }),
    UpdateUsernameRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.UpdateUsernameView();
        }),
    BottomNav.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<BottomNavArgs>(orElse: () => const BottomNavArgs());
          return _i13.BottomNav(key: args.key);
        }),
    ForgotPasswordRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i14.ForgotPasswordView();
        }),
    PhoneAuthRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.PhoneAuthView();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartupRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-view'),
        _i1.RouteConfig(SignupRoute.name, path: '/signup-view'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i1.RouteConfig(PhoneVerifyRoute.name, path: '/phone-verify-view'),
        _i1.RouteConfig(SportsTypeRoute.name, path: '/sports-type-view'),
        _i1.RouteConfig(ProfileRoute.name, path: '/profile-view'),
        _i1.RouteConfig(ChangeEmailRoute.name, path: '/change-email-view'),
        _i1.RouteConfig(ChangePasswordRoute.name,
            path: '/change-password-view'),
        _i1.RouteConfig(UpdateUsernameRoute.name,
            path: '/update-username-view'),
        _i1.RouteConfig(BottomNav.name, path: '/bottom-nav'),
        _i1.RouteConfig(ForgotPasswordRoute.name,
            path: '/forgot-password-view'),
        _i1.RouteConfig(PhoneAuthRoute.name, path: '/phone-auth-view')
      ];
}

class StartupRoute extends _i1.PageRouteInfo {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-view');

  static const String name = 'HomeRoute';
}

class SignupRoute extends _i1.PageRouteInfo {
  const SignupRoute() : super(name, path: '/signup-view');

  static const String name = 'SignupRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-view');

  static const String name = 'LoginRoute';
}

class PhoneVerifyRoute extends _i1.PageRouteInfo {
  const PhoneVerifyRoute() : super(name, path: '/phone-verify-view');

  static const String name = 'PhoneVerifyRoute';
}

class SportsTypeRoute extends _i1.PageRouteInfo {
  const SportsTypeRoute() : super(name, path: '/sports-type-view');

  static const String name = 'SportsTypeRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '/profile-view');

  static const String name = 'ProfileRoute';
}

class ChangeEmailRoute extends _i1.PageRouteInfo {
  const ChangeEmailRoute() : super(name, path: '/change-email-view');

  static const String name = 'ChangeEmailRoute';
}

class ChangePasswordRoute extends _i1.PageRouteInfo {
  const ChangePasswordRoute() : super(name, path: '/change-password-view');

  static const String name = 'ChangePasswordRoute';
}

class UpdateUsernameRoute extends _i1.PageRouteInfo {
  const UpdateUsernameRoute() : super(name, path: '/update-username-view');

  static const String name = 'UpdateUsernameRoute';
}

class BottomNav extends _i1.PageRouteInfo<BottomNavArgs> {
  BottomNav({_i2.Key? key})
      : super(name, path: '/bottom-nav', args: BottomNavArgs(key: key));

  static const String name = 'BottomNav';
}

class BottomNavArgs {
  const BottomNavArgs({this.key});

  final _i2.Key? key;
}

class ForgotPasswordRoute extends _i1.PageRouteInfo {
  const ForgotPasswordRoute() : super(name, path: '/forgot-password-view');

  static const String name = 'ForgotPasswordRoute';
}

class PhoneAuthRoute extends _i1.PageRouteInfo {
  const PhoneAuthRoute() : super(name, path: '/phone-auth-view');

  static const String name = 'PhoneAuthRoute';
}
