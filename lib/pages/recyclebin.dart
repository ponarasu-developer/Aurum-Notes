import 'package:aurum_notes_ver_two/pages/recycleabledtailscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';
import '../data/datas.dart';
import '../widgets/emptylist.dart';

class Recyclebin extends StatefulWidget {
  static const routename = '/recyclebin';
  const Recyclebin({Key? key}) : super(key: key);

  @override
  _RecyclebinState createState() => _RecyclebinState();
}

class _RecyclebinState extends State<Recyclebin> {
  IconData gridicondata = Icons.grid_view;

  void changeview() {
    print('hello');
    if (gridicondata == Icons.grid_view) {
      setState(() {
        gridicondata = Icons.format_list_bulleted_rounded;
      });
    } else {
      setState(() {
        gridicondata = Icons.grid_view;
      });
    }
    print(gridicondata);
  }

  @override
  Widget build(BuildContext context) {
    final fetchdata = Provider.of<dataprovider>(context);

    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(
              width: 9,
            ),
            Text(
              'Recycle Bin',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500, color: Colors.red, fontSize: 25),
            )
          ],
        ),
      ),
      body: fetchdata.recyclebinlistcopy.isEmpty
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
                    itemCount: fetchdata.recyclebinlistcopy.length,
                    itemBuilder: (BuildContext context, int int) {
                      return Dismissible(
                        key: ValueKey(fetchdata.recyclebinlistcopy[int]),
                        onDismissed: (direction) {
                          fetchdata.recyclebindismissable(int);
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
                                          fetchdata.recycblebindelte(int);
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
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                recyclebledetailscreen.routename,
                                arguments: int);
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
                                        '${fetchdata.recyclebinlistcopy[int].title}',
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
                                              '${fetchdata.recyclebinlistcopy[int].paragraph}',
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
                    itemCount: fetchdata.recyclebinlistcopy.length,
                    itemBuilder: (BuildContext context, int int) {
                      return Dismissible(
                        key: ValueKey(fetchdata.recyclebinlistcopy[int]),
                        onDismissed: (direction) {
                          fetchdata.recyclebindismissable(int);
                        },
                        direction: DismissDirection.endToStart,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                recyclebledetailscreen.routename,
                                arguments: int);
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
                                          fetchdata.recycblebindelte(int);
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
                                        '${fetchdata.recyclebinlistcopy[int].title}',
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
                                              '${fetchdata.recyclebinlistcopy[int].paragraph}',
                                        ),
                                        maxLines: 7,
                                        //  overflow: TextOverflow.ellipsis,
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
                ),
    );
  }
}
