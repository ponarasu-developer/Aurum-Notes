import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/datas.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:aurum_notes_ver_two/pages/detailscreen.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class List_view extends StatelessWidget {
  const List_view({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final fetchdata = Provider.of<dataprovider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: fetchdata.mainlistcopy.length,
          itemBuilder: (BuildContext context, int int) {
            return Dismissible(
              key: ValueKey(fetchdata.mainlistcopy[int]),
              onDismissed: (direction) {
                fetchdata.dissmisable(int);

                showTopSnackBar(
                  context,
                  CustomSnackBar.success(
                    message: 'Note archived',
                  ),
                  showOutAnimationDuration: Duration(milliseconds: 300),
                  hideOutAnimationDuration: Duration(milliseconds: 200),
                  displayDuration: Duration(milliseconds: 300),
                );
              },
              direction: DismissDirection.endToStart,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(detailscreen.routename, arguments: int);
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you wish to delete this item?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                fetchdata.delete(
                                    intiger: int,
                                    id: fetchdata.mainlistcopy[int].id);
                                Navigator.of(context).pop(true);

                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.info(
                                    message: 'Note Deleted',
                                  ),
                                  showOutAnimationDuration:
                                      Duration(seconds: 1),
                                  hideOutAnimationDuration:
                                      Duration(milliseconds: 200),
                                  displayDuration: Duration(seconds: 1),
                                );
                              },
                              child: const Text("DELETE")),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("CANCEL"),
                          ),
                        ],
                      );
                    },
                  );
                },
                splashColor: Colors.redAccent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Container(
                    child: Card(
                      color: Colors.grey[300],
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${fetchdata.mainlistcopy[int].title}',
                              //   overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffff007f),
                                  fontSize: 25),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: GoogleFonts.titilliumWeb(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  text:
                                      '${fetchdata.mainlistcopy[int].paragraph}'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
