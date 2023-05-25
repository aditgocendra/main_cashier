import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:main_cashier/color_app.dart';

import 'package:main_cashier/core/router/routes.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'presentation/home/home_view.dart';
import 'presentation/sign_in/sign_in_view.dart';

import 'presentation/splash/splash_view.dart';
import 'presentation/transaction/transaction_view.dart';
import 'providers.dart';

void main() {
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  String _setInitialLocation(bool? isLoggedIn, UserEntity? user) {
    if (isLoggedIn == null) return Routes.splashPath;

    if (isLoggedIn) {
      if (user == null || user.roleId == 2) return Routes.transactionPath;
      return Routes.homePath;
    }

    return Routes.signInPath;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listProvider,
      child: Builder(
        builder: (context) {
          final authState = context.watch<AuthState>();
          final colorApp = context.watch<ColorApp>();

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: GoRouter(
              initialLocation: _setInitialLocation(
                authState.isLoggedIn,
                authState.userEntity,
              ),
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
                    return SignInView();
                  },
                ),
              ],
            ),
            theme: ThemeData(
              scaffoldBackgroundColor: colorApp.background,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: colorApp.primary,
              ),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: colorApp.primary,
                  ),
                ),
                floatingLabelStyle: TextStyle(
                  color: colorApp.primary,
                ),
                hoverColor: colorApp.primary,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorApp.border),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
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
