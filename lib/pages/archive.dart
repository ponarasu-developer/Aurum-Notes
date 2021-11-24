import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:provider/provider.dart';
import '../data/datas.dart';
import '../widgets/emptylist.dart';

class Archive extends StatefulWidget {
  static const routename = '/archive';
  const Archive({Key? key}) : super(key: key);

  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
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
    final fetchdata = Provider.of<dataprovider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined)),
        actions: [
          IconButton(
              onPressed: () {
                changeview();
              },
              // color: Colors.black,
              icon: Icon(gridicondata)),
          SizedBox(
            width: 3,
          ),
        ],
        iconTheme: Theme.of(context).iconTheme,
        //   iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 9,
            ),
            Text(
              'Archive ',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  color: Colors.lightGreen,
                  fontSize: 25),
            )
          ],
        ),
      ),
      body: fetchdata.archivelistcopy.isEmpty
          ? emptylist()
          : gridicondata == Icons.grid_view
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    itemCount: fetchdata.archivelistcopy.length,
                    itemBuilder: (BuildContext context, int int) {
                      return Dismissible(
                        key: ValueKey(fetchdata.archivelistcopy[int]),
                        onDismissed: (direction) {
                          fetchdata.archivelistdismissable(int);
                          showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                              message: 'Note Re-added',
                            ),
                            showOutAnimationDuration:
                                Duration(milliseconds: 300),
                            hideOutAnimationDuration:
                                Duration(milliseconds: 200),
                            displayDuration: Duration(milliseconds: 300),
                          );
                        },
                        direction: DismissDirection.endToStart,
                        child: InkWell(
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
                                          fetchdata.archivelistdelete(int);
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text("DELETE")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
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
                                elevation: 4,
                                color: Colors.grey[300],
                                shadowColor: Colors.black,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${fetchdata.archivelistcopy[int].title}',
                                        //   overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffff007f),
                                            fontSize: 25),
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: GoogleFonts.titilliumWeb(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                          text:
                                              '${fetchdata.archivelistcopy[int].paragraph}',
                                        ),
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
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      itemCount: fetchdata.archivelistcopy.length,
                      itemBuilder: (BuildContext context, int int) {
                        return Dismissible(
                          key: ValueKey(fetchdata.archivelistcopy[int]),
                          onDismissed: (direction) {
                            fetchdata.archivelistdismissable(int);
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: 'Note Re-added',
                              ),
                              showOutAnimationDuration: Duration(seconds: 1),
                              hideOutAnimationDuration:
                                  Duration(milliseconds: 200),
                              displayDuration: Duration(milliseconds: 300),
                            );
                          },
                          direction: DismissDirection.endToStart,
                          child: InkWell(
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
                                            fetchdata.archivelistdelete(int);
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text("DELETE")),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
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
                                  elevation: 4,
                                  color: Colors.grey[300],
                                  shadowColor: Colors.black,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${fetchdata.archivelistcopy[int].title}',
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
                                                '${fetchdata.archivelistcopy[int].paragraph}',
                                          ),

                                          overflow: TextOverflow.ellipsis,
                                          maxLines:
                                              7, //  overflow: TextOverflow.ellipsis,
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
                ),
    );
  }
}
