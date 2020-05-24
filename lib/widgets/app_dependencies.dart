import 'package:bytebank2/dao/contact_dao.dart';
import 'package:bytebank2/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    @required this.contactDAO,
    @required this.transactionWebClient,
    @required Widget child,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDAO != oldWidget.contactDAO ||
        transactionWebClient != oldWidget.transactionWebClient;
  }
}
