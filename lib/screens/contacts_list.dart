import 'package:bytebank2/components/progress.dart';
import 'package:bytebank2/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/screens/contact_form.dart';
import 'package:bytebank2/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDAO _contactDAO = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _contactDAO.findAll(),
        builder: (context, snapshot) {
//          BOM VALIDAR SE O SNAPSHOT É VAZIO, PQ O FUTURE PODE DEMORAR
//          QUANDO UTILIZAR O initialData:, NÃO TEM NECESSIDADE DESSA VALIDAÇÃO
//          PORÉM É NECESSARIO PASSAR O TIPO DE LISTA NO FutureBuilder
//          if(snapshot.data != null) {

          switch (snapshot.connectionState) {
            case ConnectionState
                .none: // Future ainda não foi executado, pode usar para chamar o Future
              // TODO: Handle this case.
              break;
            case ConnectionState
                .waiting: // Future está carregando, bom para loading
              return Progress();
              break;
            case ConnectionState
                .active: // Tem dado disponível mas não terminou completamente. Stream
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              final List<Contact> contactsList = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contactsList[index];
                  return _ContactItem(contact, onClick: () {
                    debugPrint('Entrei aqui');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionForm(contact)));
                  },);
                },
                itemCount: contactsList.length,
              );
              break;
          }

          return Text('Unknown error');
//          }
//          EXIBE O LOADING
//          return Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                CircularProgressIndicator(),
//                Text('Loading'),
//              ],
//            ),
//          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => ContactForm(),
          ))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
