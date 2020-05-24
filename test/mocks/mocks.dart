import 'package:bytebank2/dao/contact_dao.dart';
import 'package:bytebank2/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDAO {}

class MockTransactionWebClient extends Mock implements TransactionWebClient {}
