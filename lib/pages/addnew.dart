import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/datas.dart';
import 'package:google_fonts/google_fonts.dart';

class Addnew extends StatefulWidget {
  static const routename = '/addnew';
  const Addnew({Key? key}) : super(key: key);

  @override
  _AddnewState createState() => _AddnewState();
}

class _AddnewState extends State<Addnew> {
  // ignore: non_constant_identifier_names
  final Title = TextEditingController();
  final paragraph = TextEditingController();
  @override
  void dispose() {
    Title.dispose();
    paragraph.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

    final fdata = Provider.of<dataprovider>(context);

    Future<bool> _willpop() async {
      final showpop = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'))
            ], content: Text('Do you want to leave with out change ?'));
          });

      return showpop ?? false;
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: WillPopScope(
        onWillPop: _willpop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme,
            // iconTheme: IconThemeData(color: Colors.black),
            title: Text('Draw Your Thoughts',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    //color: Colors.black,
                    fontSize: 20)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                        //focusNode: FocusScope.of(context).requestFocus(myFocusNode),
                        controller: Title,
                        style: TextStyle(),
                        maxLength: 40,
                        //maxLines: 3,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.title_rounded,
                              size: 30,
                            ),
                            hintText: "type your title here......",
                            labelText: "Title",
                            //  helperText: "Enter your title "
                            labelStyle: TextStyle(
                              fontSize: 20,
                              //   color: Colors.black,
                            )),
                      ),
                    ),
                    Text("Notes",
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: paragraph,
                        maxLines: 30,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "type your notes here......",
                            //  labelText: "Notes",
                            //  helperText: "Enter your title "
                            labelStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.blueAccent,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (Title.text.isEmpty && paragraph.text.isEmpty) {
                return;
              } else {
                fdata.add(Title.text, paragraph.text);
                Navigator.pop(
                  context,
                );
              }
            },
            child: Icon(
              Icons.save_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
