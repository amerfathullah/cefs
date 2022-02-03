// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth.dart';
// import '../providers/cart.dart';
// import '../providers/checklist.dart';
// import '../screens/checklist_detail_screen.dart';

// class ChecklistItem extends StatelessWidget {
//   // final String id;
//   // final String title;
//   // final String imageUrl;

//   // ChecklistItem(this.id, this.title, this.imageUrl);

//   @override
//   Widget build(BuildContext context) {
//     final checklist = Provider.of<Checklist>(context, listen: false);
//     final cart = Provider.of<Cart>(context, listen: false);
//     final authData = Provider.of<Auth>(context, listen: false);
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed(
//               ChecklistDetailScreen.routeName,
//               arguments: checklist.id,
//             );
//           },
//           child: Image.network(
//             checklist.imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.black87,
//           leading: Consumer<Checklist>(
//             builder: (ctx, checklist, _) => IconButton(
//               onPressed: () {
//                 checklist.toggleFavoriteStatus(
//                   authData.token,
//                   authData.userId,
//                 );
//               },
//               icon: Icon(checklist.isFavorite
//                   ? Icons.favorite
//                   : Icons.favorite_border),
//               color: Theme.of(context).accentColor,
//             ),
//           ),
//           title: Text(
//             checklist.foamTender,
//             textAlign: TextAlign.center,
//           ),
//           trailing: IconButton(
//             onPressed: () {
//               cart.addItem(
//                 checklist.id,
//                 checklist.price,
//                 checklist.foamTender,
//               );
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Added item to cart',
//                   ),
//                   duration: Duration(seconds: 2),
//                   action: SnackBarAction(
//                       label: 'UNDO',
//                       onPressed: () {
//                         cart.removeSingleItem(checklist.id);
//                       }),
//                 ),
//               );
//             },
//             icon: Icon(Icons.shopping_cart),
//             color: Theme.of(context).accentColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
