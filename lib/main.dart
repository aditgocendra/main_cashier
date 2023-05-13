import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:main_cashier/core/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'presentation/home/home_view.dart';
import 'presentation/sign_in/sign_in_view.dart';

import 'presentation/splash/splash_view.dart';
import 'presentation/transaction/transaction_view.dart';
import 'providers.dart';
import 'core/constant/color_constant.dart';

void main() {
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listProvider,
      child: Builder(
        builder: (context) {
          final authState = context.watch<AuthState>();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: GoRouter(
                initialLocation: (authState.isLoggedIn == null)
                    ? Routes.splashPath
                    : (authState.isLoggedIn!)
                        ? Routes.homePath
                        : Routes.signInPath,
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.homePath,
                    name: Routes.home,
                    builder: (BuildContext context, GoRouterState state) {
                      return const HomeView();
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        path: Routes.transaction,
                        name: Routes.transaction,
                        builder: (BuildContext context, GoRouterState state) {
                          return TransactionView();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: Routes.splashPath,
                    name: Routes.splash,
                    builder: (context, state) {
                      return const SplashView();
                    },
                  ),
                  GoRoute(
                    path: Routes.signInPath,
                    name: Routes.signIn,
                    builder: (context, state) {
                      return const SignInView();
                    },
                  ),
                ]),
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme.apply(
                      bodyColor: Colors.black,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
