import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/screens/add_edit_contact.dart';
import 'package:flutter/material.dart';

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