import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/checklist_preview_screen.dart';
import '../providers/checklists.dart';
import '../screens/edit_checklist_screen.dart';

class UserChecklistItem extends StatelessWidget {
  final String id;
  final String foamTender;
  final String regNo;

  UserChecklistItem(
    this.id,
    this.foamTender,
    this.regNo,
  );
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ChecklistPreviewScreen.routeName, arguments: id);
      },
      title: Text(foamTender),
      subtitle: Text(regNo),
      leading: Icon(Icons.picture_as_pdf),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditChecklistScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Checklists>(context, listen: false)
                      .deleteChecklist(id);
                } catch (e) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting Failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
