import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});
  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async{
    if(await Permission.contacts.request().isGranted){
      print("permission is granted!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      var contacts = await ContactsService.getContacts(
        withThumbnails: false,
      );

      // var -> state
      setState(() {
        _contacts = contacts;
      });
    }
    else{
      print("contact is rejected!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('연락처'),
      ),
      body: _contacts == null
          ? Center(child: Text("_contacts is null.."))
          : _contacts!.isEmpty
          ? Center(child: Text('No contacts found'))
          : ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, index) {
          Contact contact = _contacts![index];
          return ListTile(
            title: Text(contact.displayName ?? 'No Name'),
            subtitle: Text(contact.phones!.isNotEmpty ? contact.phones!.first.value ?? 'No Number' : 'No Number'),
          );
        },
      ),
    );
  }
}
