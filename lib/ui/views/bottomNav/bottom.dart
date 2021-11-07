import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/ui/views/profile/profile_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: kDarkBlue,
        backgroundColor: kWhite,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.network_check_sharp,
            size: 30,
            color: kWhite,
          ),
          Icon(
            Icons.people,
            size: 30,
            color: kWhite,
          ),
          Icon(
            Icons.manage_accounts_rounded,
            size: 30,
            color: kWhite,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _page == 0
          ? Container(
              color: kWhite,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(_page.toString(), textScaleFactor: 10.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kDarkBlue),
                      child: Text('Discover'),
                      onPressed: () {
                        //Page change using state does the same as clicking index 1 navigation button
                        // final CurvedNavigationBarState? navBarState =
                        //     _bottomNavigationKey.currentState;
                        // navBarState?.setPage(1);
                      },
                    )
                  ],
                ),
              ),
            )
          : _page == 1
              ? Container(
                  color: kWhite,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(_page.toString(), textScaleFactor: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: kDarkBlue),
                          child: Text('Buddies'),
                          onPressed: () {
                            //Page change using state does the same as clicking index 1 navigation button
                            final CurvedNavigationBarState? navBarState =
                                _bottomNavigationKey.currentState;
                            navBarState?.setPage(1);
                          },
                        )
                      ],
                    ),
                  ),
                )
              : ProfileView(),
    );
  }
}
