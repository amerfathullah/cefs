import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/dashboard_screen.dart';
import './screens/splash_screen.dart';
import './providers/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_checklist_screen.dart';
import './screens/user_checklists_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/checklist_detail_screen.dart';
import './screens/checklists_overview_screen.dart';
import 'providers/checklists.dart';
import './screens/orders_screen.dart';
import 'screens/edit_checklist_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Checklists>(
          update: (ctx, auth, previousChecklists) => Checklists(
              auth.token,
              auth.userId,
              previousChecklists == null ? [] : previousChecklists.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrder) => Orders(auth.token, auth.userId,
              previousOrder == null ? [] : previousOrder.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'CEFS',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.redAccent,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.tryAutologin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ChecklistDetailScreen.routeName: (ctx) => ChecklistDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserChecklistsScreen.routeName: (ctx) => UserChecklistsScreen(),
            EditChecklistScreen.routeName: (ctx) => EditChecklistScreen(),
            // EditChecklist.routeName: (ctx) => EditChecklist(),
          },
        ),
      ),
    );
  }
}
