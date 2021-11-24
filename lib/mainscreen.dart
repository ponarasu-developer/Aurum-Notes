import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:aurum_notes_ver_two/pages/archive.dart';

import 'package:aurum_notes_ver_two/pages/recyclebin.dart';
import './data/themes.dart';
import './pages/addnew.dart';
import './data/datas.dart';
import './widgets/emptylist.dart';
import './widgets/gridview.dart';
import './widgets/listview.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.isExpanded,
  });

  Widget expandedValue;
  Widget headerValue;
  bool isExpanded;
}

// ignore: camel_case_types
class Aurum_notes extends StatefulWidget {
  static const routename = '/';
  @override
  _Aurum_notesState createState() => _Aurum_notesState();
}

// ignore: camel_case_types
class _Aurum_notesState extends State<Aurum_notes> {
  IconData gridicondata = Icons.grid_view;

  int crossAxisCount = 2;
  @override
  void initState() {
    Provider.of<dataprovider>(context, listen: false).fetcheddata();
    super.initState();
  }

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
    final fetchdata = Provider.of<dataprovider>(context);
    final themedartas = Provider.of<themes>(context);
    // ignore: non_constant_identifier_names
    int Selectedvalue = 0;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff15e6ed),
        notchMargin: 8,
        child: Container(
          height: 50,
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 3,
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
          IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, Addnew.routename);
              },
              color: Colors.black,
              icon: Icon(Icons.add)),
          Container(
            width: 20,
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff15e6ed), Color(0xff00eaff)])),
        ),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notes_rounded,
                color: Colors.black,
              ),
              Text(
                'Aurum notes',
                style: GoogleFonts.titilliumWeb(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Aurum Notes',
                          style: TextStyle(fontSize: 20),
                        ),
                        height: 40,
                      ),
                      IconButton(
                          onPressed: () {
                            themedartas.Onchangetheme();
                          },
                          icon: Icon(themedartas.themeicon))
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, Archive.routename).then((_) {
                    setState(() {});
                  });
                },
                leading: const Icon(Icons.archive_outlined,
                    color: Colors.lightGreen),
                title: const Text('Archive'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, Recyclebin.routename).then((_) {
                    setState(() {});
                  });
                },
                title: const Text('Recycle bin'),
                leading: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                ),
              ),
              Divider(
                color: Colors.black26,
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.settings_input_antenna),
                title: const Text('Version 0.6'),
              ),
              Divider(
                color: Colors.black26,
                height: 20,
              ),
            ],
          ),
        ),
      ),
      body: fetchdata.mainlistcopy.isEmpty
          ? emptylist()
          : gridicondata == Icons.grid_view
              ? Grid_viewdisplay()
              : List_view(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff007f),
        onPressed: () async {
          Navigator.pushNamed(context, Addnew.routename);

          //final Object? get = result;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
