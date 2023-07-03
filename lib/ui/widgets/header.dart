import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfile;
  final bool showReturn;

  const Header({
    required this.title,
    required this.showProfile,
    required this.showReturn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        color: Colors.transparent,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            showReturnButton(context),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            showTheProfile(context),
          ],
        ),
      ),
    );
  }

  Widget showTheProfile(context) {
    if (showProfile) {
      return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        width: 50,
        height: 50,
        child: IconButton(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          icon: const Icon(Icons.person),
        ),
      );
    } else {
      return const SizedBox(
        width: 50,
        height: 50,
      );
    }
  }

  Widget showReturnButton(context) {
    if (showReturn) {
      return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        width: 50,
        height: 50,
        child: IconButton(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      );
    } else {
      return const SizedBox(
        width: 50,
        height: 50,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
