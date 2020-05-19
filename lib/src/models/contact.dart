class Contact{
  int id;
  String name;
  String mobNumber;
  String phNumber;
  String photo;
  bool isFavorite;

  Contact({this.name, this.mobNumber, this.phNumber, this.photo,
      this.isFavorite});

  factory Contact.fromDatabaseJson(Map<String, dynamic> data) => Contact(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Contact object
    name: data['name'],
    mobNumber: data['mobNumber'],
    phNumber: data['phNumber'],
    photo: data['photo'],
    //Since sqlite doesn't have boolean type for true/false
    //we will 0 to denote that it is false
    //and 1 for true
    isFavorite: data['isFavorite'] == 0 ? false : true,
  );
  Map<String, dynamic> toDatabaseJson() => {
    //This will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON
    "name": this.name,
    "mobNumber": this.mobNumber,
    "phNumber": this.phNumber,
    "photo": this.photo,
    "isFavorite": this.isFavorite == false ? 0 : 1,
  };
}