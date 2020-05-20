import 'package:contactapp/src/blocs/contact_bloc.dart';
import 'package:contactapp/src/blocs/favorite_contact_bloc.dart';
import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditContact extends StatelessWidget {
  final pageTitle;
  final Contact contact;

  AddEditContact({Key key, this.pageTitle, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyCustomFormState.contact = contact;
    MyCustomFormState.pageTitle = pageTitle;
    MyCustomFormState.isFavorite = contact != null ? contact.isFavorite : false;
    return MyCustomForm();
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

// of the TextField.
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final phNumberController = TextEditingController();
  static bool isFavorite = false;
  var photo;
  var utils = Utils();
  static Contact contact;
  static String pageTitle;

  @override
  void initState() {
    if (contact != null) {
      nameController.text = contact.name;
      mobileController.text = contact.mobNumber;
      phNumberController.text = contact.phNumber;
      isFavorite = contact.isFavorite;
      photo = contact.photo == null
          ? "https://i.imgur.com/BoN9kdC.png"
          : contact.photo;
    } else {
      contact = Contact(
        id: -1,
      );
      photo = "https://i.imgur.com/BoN9kdC.png";
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    mobileController.dispose();
    phNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    print("====$contact");
    print('===='+contact.id.toString());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          flexibleSpace: IconButton(
            iconSize: 40,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.only(right: 20, top: 33),
            alignment: Alignment.bottomRight,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              _submittedForm(true);
            },
          ),
          title: Text(
            pageTitle == null ? "Add New Contact" : pageTitle,
          )),
      body: ListView(
        children: <Widget>[
          Container(
              //color: Colors.grey,
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => {},
                        child: Container(
                          width: 110,
                          height: 110,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: photo == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 90,
                                )
                              : Image.network(photo),
                        )),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Name",
                            textScaleFactor: 1.5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ), // give it width
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 15),
                            child: TextFormField(
                              maxLines: 1,
                              controller: nameController,
                              decoration: _getTextFieldDeco(),
                              keyboardType: TextInputType.text,
                              // The validator receives the text that the user has entered.
                              validator: (value) =>
                                  utils.isFieldEmpty(value, "name"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Mobile",
                            textScaleFactor: 1.5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ), // give it width
                        Flexible(
                          child: TextFormField(
                            maxLines: 1,
                            maxLength: 10,
                            controller: mobileController,
                            decoration: _getTextFieldDeco(),
                            keyboardType: TextInputType.number,
                            // The validator receives the text that the user has entered.
                            validator: (value) =>
                                utils.isFieldEmpty(value, "mobile number"),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Landline",
                            textScaleFactor: 1.5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ), // give it width
                        Flexible(
                          child: TextFormField(
                            maxLines: 1,
                            maxLength: 11,
                            controller: phNumberController,
                            decoration: _getTextFieldDeco(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Align(
                      child: RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            _submittedForm(false);
                          },
                          child: Text(
                            contact != null &&
                            contact.id != null &&
                                contact.id > 0
                                ? 'Update'
                                : "Save",
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _submittedForm(bool isFavoriteCall) {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      if (isFavoriteCall)
        setState(() {
          isFavorite = !isFavorite;
        });

      if (contact.id <= 0) {
        contact = Contact(
            isFavorite: isFavorite,
            name: nameController.text,
            mobNumber: mobileController.text,
            phNumber: phNumberController.text);
        contactBloc.addTodo(contact);
        fContactBloc.addTodo(contact);
      } else {
        contact = Contact(
            id: contact.id,
            isFavorite: isFavorite,
            name: nameController.text,
            mobNumber: mobileController.text,
            phNumber: phNumberController.text);
        contactBloc.updateTodo(contact);
        fContactBloc.updateTodo(contact);
      }
       Navigator.pop(context);
    }
  }

  _getTextFieldDeco() {
    return const InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            borderSide: BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ));
  }
}
