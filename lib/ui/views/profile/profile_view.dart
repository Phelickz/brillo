import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/login/login.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (ProfileViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        ProfileViewModel model,
        Widget? child,
      ) {
        User? user = FirebaseAuth.instance.currentUser;
        return Skeleton(
          isBusy: model.isBusy,
          backgroundColor: kWhite,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpaceMedium(context),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kDarkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 45,
                    ),
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  (user != null) ? user.displayName! : "",
                  style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 2.7),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  (user != null) ? user.email! : "",
                  style: CustomThemeData.generateStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  "Contact: ${model.data['phoneNumber']}",
                  style: CustomThemeData.generateStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  "Interests: ${model.data['interests']}",
                  style: CustomThemeData.generateStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                verticalSpaceMedium(context),
                SizedBox(
                  width: McGyver.rsDoubleW(context, 50),
                  child: CustomButtons.generalButton(
                    context: context,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content) => Settings(phone: model.data['phoneNumber'],)));
                    },
                    text: "Settings",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Settings extends StatelessWidget {
  final String? phone;
  Settings({Key? key, this.phone}) : super(key: key);
  final routerService = locator<RouterService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text(
          'Settings and Privacy',
          style: GoogleFonts.dmSans(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            routerService.router.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceSmall(context),
              verticalSpaceXSmall(context),
              phone == null || phone!.isEmpty
                  ? Card(
                      elevation: 3,
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          routerService.router.push(PhoneVerifyRoute());
                        },
                        title: Text(
                          'Add Phone Number',
                          style: CustomThemeData.generateStyle(
                            fontSize: McGyver.textSize(context, 2),
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              verticalSpaceXSmall(context),
              Card(
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    routerService.router.push(ChangePasswordRoute());
                  },
                  title: Text(
                    'Change Password',
                    style: CustomThemeData.generateStyle(
                      fontSize: McGyver.textSize(context, 2),
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              verticalSpaceXSmall(context),
              Card(
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    routerService.router.push(ChangeEmailRoute());
                  },
                  title: Text(
                    'Update Email',
                    style: CustomThemeData.generateStyle(
                      fontSize: McGyver.textSize(context, 2),
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              verticalSpaceXSmall(context),
              Card(
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    routerService.router.push(UpdateUsernameRoute());
                  },
                  title: Text(
                    'Update Username',
                    style: CustomThemeData.generateStyle(
                      fontSize: McGyver.textSize(context, 2),
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              verticalSpaceXSmall(context),
              Card(
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  title: Text(
                    'Log Out',
                    style: CustomThemeData.generateStyle(
                      fontSize: McGyver.textSize(context, 2),
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
