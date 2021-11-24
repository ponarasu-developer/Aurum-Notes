import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/datas.dart';

// ignore: camel_case_types
class recyclebledetailscreen extends StatefulWidget {
  static const routename = '/recyclebledetailscreen';
  const recyclebledetailscreen({Key? key}) : super(key: key);

  @override
  _recyclebledetailscreenState createState() => _recyclebledetailscreenState();
}

// ignore: camel_case_types
class _recyclebledetailscreenState extends State<recyclebledetailscreen> {
  @override
  Widget build(BuildContext context) {
    final showdata = ModalRoute.of(context)!.settings.arguments as int;
    final detaildata = Provider.of<dataprovider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      elevation: 0,
                      duration: Duration(milliseconds: 300),
                      content: Text('Restore first to edit')));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //  color: Colors.black,
                width: double.infinity,
                child: Text(
                  detaildata.recyclebinlistcopy[showdata].title,
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
                //  color: Colors.green,
                width: double.infinity,
                child: Text(detaildata.recyclebinlistcopy[showdata].paragraph),
              )
            ],
          ),
        ),
      ),
    );
  }
}
