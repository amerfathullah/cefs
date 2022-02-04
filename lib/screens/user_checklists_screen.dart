import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_checklist_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_checklist_item.dart';
import '../providers/checklists.dart';

class UserChecklistsScreen extends StatelessWidget {
  static const routeName = '/user-checklists';

  Future<void> _refreshChecklists(BuildContext context) async {
    await Provider.of<Checklists>(context, listen: false)
        .fetchAndSetChecklists(false);
  }

  @override
  Widget build(BuildContext context) {
    // final checklistsData = Provider.of<Checklists>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Checklists'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditChecklistScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshChecklists(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshChecklists(context),
                    child: Consumer<Checklists>(
                      builder: (ctx, checklistsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: checklistsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserChecklistItem(
                                checklistsData.items[i].id,
                                checklistsData.items[i].foamTender,
                                // '',
                                // checklistsData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
