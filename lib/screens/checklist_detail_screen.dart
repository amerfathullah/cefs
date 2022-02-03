import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/checklists.dart';

class ChecklistDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ChecklistDetailScreen(this.title, this.price);
  static const routeName = '/checklist-detail';

  @override
  Widget build(BuildContext context) {
    final checklistId =
        ModalRoute.of(context).settings.arguments as String; //is the id!
    final loadedChecklist =
        Provider.of<Checklists>(context, listen: false).findById(checklistId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedChecklist.foamTender),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 300,
            //   width: double.infinity,
            //   child: Image.network(
            //     loadedChecklist.imageUrl,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(height: 10),
            // Text(
            //   '\$${loadedChecklist.price}',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 20,
            //   ),
            // ),
            SizedBox(height: 10),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   width: double.infinity,
            //   child: Text(
            //     loadedChecklist.description,
            //     textAlign: TextAlign.center,
            //     softWrap: true,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
