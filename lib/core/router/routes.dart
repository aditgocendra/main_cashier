import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main_cashier/presentation/sign_in/sign_in_view.dart';

import '../../presentation/home/home_view.dart';
import '../../presentation/transaction/transaction_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'transaction',
          builder: (BuildContext context, GoRouterState state) {
            return TransactionView();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/sign_in',
      builder: (context, state) {
        return const SignInView();
      },
    )
  ],
);
