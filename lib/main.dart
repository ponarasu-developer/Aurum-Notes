import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import './mainscreen.dart';
import './pages/favorite.dart';
import './pages/archive.dart';
import './pages/recyclebin.dart';

import './data/datas.dart';
import './pages/addnew.dart';
import './pages/detailscreen.dart';
import './pages/recycleabledtailscreen.dart';
import './data/themes.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => dataprovider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => themes(),
        )
      ],
      child: Aurumnotes(),
    );
  }
}

class Aurumnotes extends StatefulWidget {
  const Aurumnotes({Key? key}) : super(key: key);

  @override
  _AurumnotesState createState() => _AurumnotesState();
}

class _AurumnotesState extends State<Aurumnotes> {
  @override
  Widget build(BuildContext context) {
    final themedata = Provider.of<themes>(context);
    return MaterialApp(
      themeMode: themedata.currenttheme,
      theme: ThemeData(
          colorScheme: ColorScheme.light(),
          iconTheme: IconThemeData(color: Colors.black)),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(),
          iconTheme: IconThemeData(color: Colors.white)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Aurum_notes.routename: (context) => Aurum_notes(),
        Favorite.routename: (context) => Favorite(),
        Archive.routename: (context) => Archive(),
        Recyclebin.routename: (context) => Recyclebin(),
        Addnew.routename: (context) => Addnew(),
        detailscreen.routename: (context) => detailscreen(),
        recyclebledetailscreen.routename: (context) => recyclebledetailscreen()
      },
    );
  }
}
