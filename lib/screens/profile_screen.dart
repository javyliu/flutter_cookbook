import 'package:cookbook/constants.dart';
import 'package:cookbook/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String name = "用户资料";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            ProfileMenu(
              icon: "assets/icons/User\ Icon.svg",
              title: "My Account",
              press: () {
                print("hello---");
              },
            ),
            ProfileMenu(
              icon: "assets/icons/Bell.svg",
              title: "Notifications",
              press: () {
                print("notifications---");
              },
            ),
            ProfileMenu(
              icon: "assets/icons/Settings.svg",
              title: "Settings",
              press: () {
                print("Settings---");
              },
            ),
            ProfileMenu(
              icon: "assets/icons/Question\ mark.svg",
              title: "Help Center",
              press: () {
                print("Help Center---");
              },
            ),
            ProfileMenu(
              icon: "assets/icons/Log\ out.svg",
              title: "Log Out",
              press: () {
                print("log out---");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xffdadada).withOpacity(0.25),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop\ Icon.svg",
                color: selectedMenu == MenuState.home ? jPrimaryColor : jSecondaryColor,
              ),
              onPressed: () => Navigator.pushNamed(context, "home_screen"),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Heart\ Icon.svg",
                color: selectedMenu == MenuState.favourite ? jPrimaryColor : jSecondaryColor,
              ),
              onPressed: () => print("favourate"),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Chat\ bubble\ Icon.svg",
                color: selectedMenu == MenuState.message ? jPrimaryColor : jSecondaryColor,
              ),
              onPressed: () => print("messages"),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User\ Icon.svg",
                color: selectedMenu == MenuState.profile ? jPrimaryColor : jSecondaryColor,
              ),
              onPressed: () => Navigator.pushNamed(context, "profile_screen"),
            ),
          ],
        ),
      ),
    );
  }
}
