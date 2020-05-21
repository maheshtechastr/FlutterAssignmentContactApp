import 'package:contactapp/src/models/contact.dart';
import 'package:contactapp/src/resource/dao/contact_dao.dart';


class ContactRepository {
  final contactDao = ContactDao();

  Future getAllContacts({String query}) => contactDao.getContacts(query: query);

  Future insertContact(Contact contact) => contactDao.createTodo(contact);

  Future updateContact(Contact contact) => contactDao.updateContact(contact);

  Future deleteContactById(int id) => contactDao.deleteContact(id);

  Future deleteAllContacts() => contactDao.deleteAllContacts();
}