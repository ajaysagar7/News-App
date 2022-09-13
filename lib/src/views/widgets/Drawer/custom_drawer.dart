import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text("AS"),
                backgroundColor: Color.fromARGB(100, 3, 23, 174),
              ),
              accountName: const Text("Ajay Sagar"),
              accountEmail: const Text("sajaysagar7@gmail.com")),
          Divider(),
          ListTile(
            title: const Text("Select Country"),
            leading: Icon(Icons.location_city),
          )
        ],
      ),
    );
  }
}
