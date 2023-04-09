import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_cashier/core/router/routes.dart';
import 'core/constant/color_constant.dart';

import 'package:provider/provider.dart';
import 'providers.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listProvider,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}
