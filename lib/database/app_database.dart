import 'package:bytebank2/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final path = join(await getDatabasesPath(), 'bytebank2.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSQL);
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );

//  return getDatabasesPath().then((dbPath) {
//    final path = join(dbPath, 'bytebank2.db');
//    return openDatabase(
//      path,
//      onCreate: (db, version) {
//        db.execute('CREATE TABLE contacts('
//            'id INTEGER PRIMARY KEY, '
//            'name TEXT, '
//            'account_number INTEGER)');
//      },
//      version: 1,
////      onDowngrade: onDatabaseDowngradeDelete,
//    );
//  });
}
