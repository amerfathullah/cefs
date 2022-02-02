import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/checklists.dart';
import './checklist_item.dart';

class ChecklistsGrid extends StatelessWidget {
  final bool showFavs;

  ChecklistsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final checklistsData = Provider.of<Checklists>(context);
    final checklists =
        showFavs ? checklistsData.favoriteItems : checklistsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: checklists.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: checklists[i],
        child: ChecklistItem(
            // checklists[i].id,
            // checklists[i].title,
            // checklists[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
