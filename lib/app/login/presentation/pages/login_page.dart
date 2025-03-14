import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      //value: LoginBloc(),
      value: DependecyInjection.serviceLocator.get<LoginBloc>(),
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    //colors: [Colors.amber, Colors.orange.shade700],
                    colors: [Colors.red, Colors.redAccent.shade700],
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeaderLoginWidget(),
                    const SizedBox(height: 40),
                    BodyLoginWidget(),
                    const SizedBox(height: 40), // Added bottom padding
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

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  final keyForm = GlobalKey<FormState>();

  bool _obscureText = true;
  Timer? _autoShowTimer;

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = context.read<LoginBloc>();

    bool isValidForm =
        keyForm.currentState != null && keyForm.currentState!.validate();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state);
        switch (state) {
          case LoginInitialState():
            break;
          case LoginEventState():
            print(state.model.email);
            break;
          case LoginErrorState():
            print(state.model);
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text("message"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.pop(context, "OK"),
                            child: const Text("OK")),
                      ],
                    ));
          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("Home");
            //context.pushReplacementNamed("Home");
            //context.go("/home");
            print(state.model);
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          /*print(state);
          switch (state) {
            case InitialState():
              break;
            case EventState():
              print(state.model.email);
              break;
            case LoginErrorState():
              print(state.model);
            case LoginSuccessState():
              //GoRouter.of(context).pushReplacementNamed("Home");
              context.go("/home");
              print(state.model);
              break;
            default:
          }*/
          /*return Card(
          child: Container(
            color: const Color.fromARGB(255, 131, 83, 83),
            child: InkWell(
              child: Text("data"),
              onDoubleTap: () {
                bloc.add(EmailChangedEvent(email: "miEmail"));
              },
            ),
          ),
        );*/
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white.withOpacity(0.7),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Text(state.model.email),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: /*TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),*/
                            TextFormField(
                          onChanged: (value) => setState(() {
                            bloc.add(EmailChangedEvent(email: value));
                            isValidForm = keyForm.currentState != null &&
                                keyForm.currentState!.validate();
                          }),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          //initialValue: "Hello there",
                          validator: (value) =>
                              validator(LoginMixin.USERNAME_FIELD, value),
                          /*{
                      
                      if (value == null || value.isEmpty) {
                        return "Usuario es obligatorio";
                      }
                    },*/
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            prefixIcon: const Icon(Icons.person_outline),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 25),
                      //Text(state.model.password),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: TextFormField(
                          onChanged: (value) => setState(() {
                            bloc.add(PasswordChangedEvent(password: value));
                            isValidForm = keyForm.currentState != null &&
                                keyForm.currentState!.validate();
                          }),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: (value) =>
                              validator(LoginMixin.PASSWORD_FIELD, value),
                          /*value == null || value.isEmpty
                                ? "Password obligatoria"
                                : null,*/
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: /*IconButton(
                      icon: Icon(
                        !_obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            _obscureText = true;
                          });
                        });
                      },
                    ),*/
                                InkWell(
                              onTap: () {
                                _autoShowTimer?.cancel();

                                if (_obscureText) {
                                  _autoShowTimer = Timer(
                                    Duration(seconds: 2),
                                    () {
                                      setState(() {
                                        _obscureText = true;
                                      });
                                    },
                                  );
                                }

                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                !_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => {
                            GoRouter.of(context).pushNamed("SignUp"),
                            //GoRouter.of(context).pushReplacementNamed("Home")
                            //context.pushNamed("SignUp"),
                          },
                          child: Text('¿Olvidaste la contraseña?'),
                        ),
                      ),
                      const SizedBox(height: 25),
                      FilledButton.icon(
                        onPressed: isValidForm
                            ? () {
                                //keyForm.currentState?.validate();
                                bloc.add(SubmitEvent());
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.amber.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.login),
                        label: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Aún no tienes cuenta?",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              //context.go("/signUp");
                              context.push("/signUp");
                            },
                            child: const Text('Registrate aqui'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Text(
            'UNAB MOVILES!',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Inicia sesión para continuar',
            style: TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
          const SizedBox(height: 32),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              "https://external-preview.redd.it/SF-eEhzM62dliitV9qofE_XTIPuImnoDR7SpiJ2PhBc.png?auto=webp&s=8b5462973995e9593a82d1b1c767c03bc7effa52",
            ),
          ),
        ],
      ),
    );
  }
}

/**
 * inkwell
 * 
 */
