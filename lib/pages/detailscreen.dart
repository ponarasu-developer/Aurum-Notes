import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/datas.dart';

// ignore: camel_case_types
class detailscreen extends StatefulWidget {
  static const routename = '/detailscreen';

  @override
  _detailscreenState createState() => _detailscreenState();
}

// ignore: camel_case_types
class _detailscreenState extends State<detailscreen> {
  bool textediting = false;

  Color iconcolor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final showdata = ModalRoute.of(context)!.settings.arguments as int;
    final detaildata = Provider.of<dataprovider>(context);
    final title =
        TextEditingController(text: detaildata.mainlistcopy[showdata].title);

    // ignore: non_constant_identifier_names
    final Paragraph = TextEditingController(
        text: detaildata.mainlistcopy[showdata].paragraph);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              // color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (textediting == false) {
                    iconcolor = Colors.red;
                    textediting = true;
                  } else {
                    textediting = false;
                  }
                });
              },
              icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                maxRadius: 60,
                child: Icon(
                  Icons.edit,
                  color: iconcolor,
                ),
              ))
        ],
      ),
      body: textediting == true
          ? Padding(
              padding: EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //  color: Colors.black,
                      width: double.infinity,
                      child: TextField(
                        controller: title,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffff007f),
                            fontSize: 26),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: Paragraph,
                        maxLines: 30,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            labelStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.blueAccent,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: SelectableText(
                        detaildata.mainlistcopy[showdata].title,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffff007f),
                            fontSize: 26),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Container(
                      width: double.infinity,
                      child: SelectableText(
                          detaildata.mainlistcopy[showdata].paragraph),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: textediting == true
          ? FloatingActionButton(
              onPressed: () {
                final titlenewdata = title.text;
                final paragraphnewdata = Paragraph.text;
                final intvaluie = showdata;
                detaildata.editable(titlenewdata, paragraphnewdata, intvaluie);
                setState(() {
                  if (textediting == false) {
                    iconcolor = Colors.red;
                    textediting = true;
                  } else {
                    iconcolor = Colors.black;
                    textediting = false;
                  }
                });
              },
              child: Icon(Icons.save),
            )
          : Container(),
    );
  }
}
