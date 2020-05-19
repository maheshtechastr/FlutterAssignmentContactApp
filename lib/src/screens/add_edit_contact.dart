import 'package:contactapp/src/blocs/contact_bloc.dart';
import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditContact extends StatelessWidget {
  final pageTitle;
  var contact = Contact();

  AddEditContact({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 2,

          //leading: IconButton(icon: Icon(Icons.favorite_border), onPressed: () {},),
          title: Row(
            children: <Widget>[
              Text(
                pageTitle == null ? "Add New Contact" : pageTitle,
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  print("Favorites Icon pressed");
                },
              )
            ],
          )),
      body: MyCustomForm(),
    );
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
  var isFavorite = false;
  var utils = Utils();

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
    return Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.black)),
                      child: Icon(
                        Icons.camera_alt,
                        size: 90,
                      ),
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
                      child: TextFormField(
                        maxLines: 1,
                        controller: nameController,
                        decoration: _getTextFieldDeco(),
                        keyboardType: TextInputType.text,
                        // The validator receives the text that the user has entered.
                        validator: (value) => utils.isFieldEmpty(value, "name"),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          contactBloc.addTodo(Contact(
                              name: nameController.text,
                              mobNumber: mobileController.text,
                              phNumber: phNumberController.text));
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                              content: Text(
//                                  nameController.text.toUpperCase()+' is added to the Contact list.')));
                          Navigator.pop(context);
                        }
                      },
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                )
              ]),
        ));
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
