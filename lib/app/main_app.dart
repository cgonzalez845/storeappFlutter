import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';
import 'package:storeapp/app/users/presentation/pages/users_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
            //return const FormProductPage();\
          },
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool? authenticated = await prefs.getBool("L0gin") ?? false;
            if (authenticated!) {
              return "/home";
            }
            return null;
          },
        ),
        //routes: <RouteBase>[
        GoRoute(
          path: '/signUp',
          builder: (_, __) => SignUpPage(),
          name: "SignUp",
          /*builder: (BuildContext context, GoRouterState state) {
                return const SignUpPage();
              }*/
        ),
        GoRoute(
          path: '/home',
          builder: (_, __) => HomePage(),
          name: "Home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool? authenticated = await prefs.getBool("L0gin") ?? false;
            if (!authenticated!) {
              return "/";
            }
            return null;
          },
          /*builder: (BuildContext context, GoRouterState state) {
                return const SignUpPage();
              }*/
          // ),
          //],
        ),
        GoRoute(
          path: '/form-product',
          builder: (_, __) => FormProductPage(),
          name: "Form-Product",
          /*builder: (BuildContext context, GoRouterState state) {
                return const SignUpPage();
              }*/
          // ),
          //],
        ),
        GoRoute(
          path: '/form-product-edit/:id',
          builder: (_, state) => FormProductPage(
            id: state.pathParameters["id"],
          ),
          name: "Form-Product-edit",
        ),
        GoRoute(
          path: '/users',
          builder: (_, __) => UsersPage(),
          name: "users",
        )
      ],
    );
    return MaterialApp.router(
      routerConfig: _router,
      /*return const MaterialApp(
      home: LoginPage()*/
      /*Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),*/
    );
  }
}

class TestStateFul extends StatefulWidget {
  const TestStateFul({super.key});

  @override
  State<TestStateFul> createState() => _TestStateFulState();
}

class _TestStateFulState extends State<TestStateFul> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
