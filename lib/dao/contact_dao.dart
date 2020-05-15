import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/models/contact.dart';

class ContactDAO {
  static const String tableSQL = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final db = await getDatabase();

    Map<String, dynamic> contactMap = toMap(contact);
    return db.insert(_tableName, contactMap);

//  return getDatabase().then((db) {
//    final Map<String, dynamic> contactMap = Map();
//    contactMap['name'] = contact.name;
//    contactMap['account_number'] = contact.accountNumber;
//    return db.insert('contacts', contactMap);
//  });
  }

  Map<String, dynamic> toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    List<Contact> contacts = toList(result);
    return contacts;

//  return getDatabase().then((db) {
//    return db.query('contacts').then((maps) {
//      final List<Contact> contacts = List();
//      for (Map<String, dynamic> map in maps) {
//        final Contact contact = Contact(
//          map['id'],
//          map['name'],
//          map['account_number'],
//        );
//        contacts.add(contact);
//      }
//      return contacts;
//    });
//  });
  }

  List<Contact> toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}