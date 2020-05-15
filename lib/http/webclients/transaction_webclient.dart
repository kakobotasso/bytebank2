import 'dart:convert';

import 'package:bytebank2/http/webclient.dart';
import 'package:bytebank2/models/transaction.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final response = await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = transaction.toJson();

    final String transactionJson = jsonEncode(transactionMap);

    final response = await client
        .post(baseUrl,
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson)
        .timeout(Duration(seconds: 5));

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
