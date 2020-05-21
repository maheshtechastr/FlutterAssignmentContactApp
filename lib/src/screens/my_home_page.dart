import 'package:contactapp/src/models/drawer_item.dart';
import 'package:contactapp/src/screens/contact_list_page.dart';
import 'package:flutter/material.dart';

import 'favorites_page.dart';

class MyHomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Contact List", Icons.contact_phone),
    new DrawerItem("Favorite Contact List", Icons.favorite_border),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

//  StreamController ctrl;
//  ContactBloc bloc = ContactBloc();
//
//  @override
//  void dispose() {
//    bloc.dispose();
//    ctrl.close();
//    super.dispose();
//  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ContactListPage();
      case 1:
        return new FavoritesPage();
      default:
        return new Text("Error...");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        centerTitle: true,
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
          child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            /*new UserAccountsDrawerHeader(
                accountName: new Text("Mahesh Gupta"), accountEmail: Text("mahesh.gupta@nagarro.com")),*/
            new Column(children: drawerOptions)
          ],
        ),
      )),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
