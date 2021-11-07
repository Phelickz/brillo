import 'package:auto_route/auto_route.dart';
import 'package:brillo/ui/views/bottomNav/bottom.dart';
import 'package:brillo/ui/views/change_email/change_email_view.dart';
import 'package:brillo/ui/views/change_password/change_password_view.dart';
import 'package:brillo/ui/views/forgot_password/forgot_password_view.dart';

import 'package:brillo/ui/views/home/home_view.dart';
import 'package:brillo/ui/views/login/login_view.dart';
import 'package:brillo/ui/views/phone_auth/phone_auth_view.dart';
import 'package:brillo/ui/views/phone_verify/phone_verify_view.dart';
import 'package:brillo/ui/views/profile/profile_view.dart';
import 'package:brillo/ui/views/signup/signup_view.dart';
import 'package:brillo/ui/views/sports_type/sports_type_view.dart';
import 'package:brillo/ui/views/startup/startup_view.dart';
import 'package:brillo/ui/views/update_username/update_username_view.dart';

export './router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "View,Route",
  routes: <AutoRoute>[
    AdaptiveRoute(page: StartupView, initial: true),
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: SignupView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: PhoneVerifyView),
    AdaptiveRoute(page: SportsTypeView),
    AdaptiveRoute(page: ProfileView),
    AdaptiveRoute(page: ChangeEmailView),
    AdaptiveRoute(page: ChangePasswordView),
    AdaptiveRoute(page: UpdateUsernameView),
    AdaptiveRoute(page: BottomNav),
    AdaptiveRoute(page: ForgotPasswordView),
    AdaptiveRoute(page: PhoneAuthView)
  ],
)
class $BrilloRouter {}