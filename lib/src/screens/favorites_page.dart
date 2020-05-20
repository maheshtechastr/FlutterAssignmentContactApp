import 'package:contactapp/src/blocs/favorite_contact_bloc.dart';
import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/screens/add_edit_contact.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FContactListState();
  }
}

class FContactListState extends State<FavoritesPage> {
  //StreamController<List<Contact>> controller;

  @override
  void initState() {
    super.initState();
    fContactBloc.getContacts(query: 1.toString());
  }
  @override
  void dispose() {
    //fContactBloc.dispose();
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    //controller = GlobalValues.of(context).controller;

    return Scaffold(
      body: StreamBuilder(
        stream: fContactBloc.contacts,
        builder: (context, AsyncSnapshot<List<Contact>> response) {
          print("Data=="+response.data.toString());
          print("HasError=="+response.hasError.toString());
          print("hasData=="+response.hasData.toString());
          if (response.hasData && response.data.length > 0) {
            return buildList(response);
          } else if (response.hasError ||
              !response.hasData ||
              response.data.length <= 0) {
            return Center(
              child: Text(
                "There is no Favorite contacts.",
                style: TextStyle(color: Colors.black87, fontSize: 20),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
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

class ListItem extends StatelessWidget {
  final Contact contact;

  ListItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              print("List Item clicked==>" + contact.name),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditContact(
                            contact: contact,
                            pageTitle: "Update Contact",
                          )))
            },
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),
              ],
            ),
            Flexible(
                child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            contact.name,
                            textScaleFactor: 1.5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            contact.mobNumber,
                            style: TextStyle(fontWeight: FontWeight.w300),
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.left,
                          )
                        ])))
          ],
        ));
  }
}
