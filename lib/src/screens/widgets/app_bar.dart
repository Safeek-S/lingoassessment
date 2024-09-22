import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color textColor;
  final Color appBarColor;

  const CustomAppBar({
    Key? key,
    required this.text,
    required this.appBarColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      automaticallyImplyLeading: false, // Set this to true if you want the default back button
      title: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // This defines the size of the app bar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

