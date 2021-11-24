import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/modles.dart';
import '../database/db_helper.dart';

// ignore: camel_case_types
class dataprovider with ChangeNotifier {
  List _mainlist = [];

  List<List_item> _favoritelist = [];

  List<List_item> _archivelist = [];

  List<List_item> _recyclebinlist = [];

  List<List_item> get mainlistcopy {
    return [..._mainlist];
  }

  List<List_item> get faviritelistcopy {
    return [..._favoritelist];
  }

  List<List_item> get archivelistcopy {
    return [..._archivelist];
  }

  List<List_item> get recyclebinlistcopy {
    return [..._recyclebinlist];
  }

  void add(
    String title,
    String paragraph,
  ) {
    final result = List_item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        paragraph: paragraph);
    _mainlist.insert(0, result);
    notifyListeners();
    Dbhelper.insert('mainlist', {
      'id': result.id,
      'title': result.title,
      'para': result.paragraph,
    });
  }

  Future<void> fetcheddata() async {
    final datalist = await Dbhelper.getdata('mainlist');
    final archivedatalist = await archivehelper.archivedata('archivelist');
    final recyclelist = await recyclehelper.recycledata('recyclelist');
    _mainlist = datalist.reversed
        .map((e) => List_item(
            id: e['id'].toString(),
            title: e['title'].toString(),
            paragraph: e['para'].toString()))
        .toList();

    _archivelist = archivedatalist.reversed
        .map((e) => List_item(
            id: e['id'].toString(),
            title: e['title'].toString(),
            paragraph: e['para'].toString()))
        .toList();

    _recyclebinlist = recyclelist.reversed
        .map((e) => List_item(
            id: e['id'].toString(),
            title: e['title'].toString(),
            paragraph: e['para'].toString()))
        .toList();
    notifyListeners();
  }

  void dissmisable(int intiger) {
    archivehelper.insert('archivelist', {
      'id': _mainlist[intiger].id,
      'title': _mainlist[intiger].title,
      'para': _mainlist[intiger].paragraph,
    });
    Dbhelper.delete('mainlist', _mainlist[intiger].id);
    _archivelist.add(_mainlist[intiger]);
    _mainlist.removeAt(intiger);
    notifyListeners();
  }

  void delete({required int intiger, required String id}) {
    recyclehelper.recycleinsert('recyclelist', {
      'id': _mainlist[intiger].id,
      'title': _mainlist[intiger].title,
      'para': _mainlist[intiger].paragraph,
    });
    Dbhelper.delete('mainlist', _mainlist[intiger].id);
    _recyclebinlist.add(_mainlist[intiger]);
    _mainlist.removeAt(intiger);

    notifyListeners();
  }

  void archivelistdismissable(int intiger) {
    Dbhelper.insert('mainlist', {
      'id': _archivelist[intiger].id,
      'title': _archivelist[intiger].title,
      'para': _archivelist[intiger].paragraph,
    });
    archivehelper.archivedelete('archivelist', _archivelist[intiger].id);
    _mainlist.add(_archivelist[intiger]);
    _archivelist.removeAt(intiger);
    notifyListeners();
  }

// delte from archive function
  void archivelistdelete(int intiger) {
    archivehelper.archivedelete('archivelist', _archivelist[intiger].id);
    _archivelist.removeAt(intiger);
    notifyListeners();
  }

//2
  void recyclebindismissable(int intiger) {
    Dbhelper.insert('mainlist', {
      'id': _recyclebinlist[intiger].id,
      'title': _recyclebinlist[intiger].title,
      'para': _recyclebinlist[intiger].paragraph,
    });
    recyclehelper.recycledelete('recyclelist', _recyclebinlist[intiger].id);
    _mainlist.add(_recyclebinlist[intiger]);
    _recyclebinlist.removeAt(intiger);
    notifyListeners();
  }

//3 deleted function form recycle bin
  void recycblebindelte(int initger) {
    recyclehelper.recycledelete('recyclelist', _recyclebinlist[initger].id);
    _recyclebinlist.removeAt(initger);
    notifyListeners();
  }

//4 edit function
  void editable(String title, String paragraph, int intger) {
    // ignore: unnecessary_cast
    //  String newtitel = title as String;
    // Map<String, String> newdatamap = {title, paragraph} ;
    Dbhelper.update('mainlist', _mainlist[intger].id, title, paragraph);
    _mainlist[intger].title = title;
    _mainlist[intger].paragraph = paragraph;
    notifyListeners();
  }
}
