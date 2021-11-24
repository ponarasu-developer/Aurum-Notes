import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Favorite extends StatefulWidget {
  static const routename = '/favorite';
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  IconData gridicondata = Icons.grid_view;

  int crossAxisCount = 2;

  void changeview() {
    if (gridicondata == Icons.grid_view && crossAxisCount == 2) {
      setState(() {
        gridicondata = Icons.format_list_bulleted_rounded;
        crossAxisCount = 1;
      });
    } else {
      setState(() {
        gridicondata = Icons.grid_view;
        crossAxisCount = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                changeview();
              },
              color: Colors.black,
              icon: Icon(gridicondata)),
          SizedBox(
            width: 3,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 9,
            ),
            Text(
              'Favorite',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  color: Color(0xffff007f),
                  fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
