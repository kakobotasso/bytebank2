import 'package:bytebank2/dao/contact_dao.dart';
import 'package:bytebank2/http/webclients/transaction_webclient.dart';
import 'package:bytebank2/screens/dashboard.dart';
import 'package:bytebank2/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp(
    contactDAO: ContactDAO(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    @required this.contactDAO,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDAO: contactDAO,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}
