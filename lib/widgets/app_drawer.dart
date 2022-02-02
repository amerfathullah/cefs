import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_checklist_screen.dart';
import '../screens/user_checklists_screen.dart';
import '../providers/auth.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Equipment Checklist'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New Checklist'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(EditChecklistScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Previous Checklist'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserChecklistsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context)
              //     .pushReplacementNamed(UserChecklistsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
