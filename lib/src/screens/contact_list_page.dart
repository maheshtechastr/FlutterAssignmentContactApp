import 'package:contactapp/src/blocs/contact_bloc.dart';
import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/screens/add_edit_contact.dart';
import 'package:contactapp/src/screens/list_item.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactListState();
  }
}

class ContactListState extends State<ContactListPage> {
  //StreamController<List<Contact>> controller;

  @override
  void initState() {
    super.initState();
    contactBloc.getContacts();
  }

  @override
  void dispose() {
    //contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    controller = GlobalValues.of(context).controller;
    return Scaffold(
      body: StreamBuilder(
        stream: contactBloc.contacts,
        builder: (context, AsyncSnapshot<List<Contact>> response) {
          if (response.hasData) {
            return buildList(response);
          } else if (response.hasError) {
            return Center(
              child: Text(
                "Please Create contacts from below '+' button",
                style: TextStyle(color: Colors.cyan),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditContact()));
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Contact>> response) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 15, right: 15),
      itemCount: response.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12)),
            ),
            child: ListItem(contact: response.data[index]));
      },
    );
  }
}

