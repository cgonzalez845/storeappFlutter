import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
/**
 * imagen
 * nombre
 * documento
 * email
 * contraseña
 * confirmar 
 */

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependecyInjection.serviceLocator.get<SignupBloc>(),
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
                    colors: [Colors.blue, Colors.indigo.shade700],
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeaderSignUpWidget(),
                    const SizedBox(height: 40),
                    BodySignUpWidget(),
                    const SizedBox(height: 40),
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

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget({super.key});

  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> with SignupMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = context.read<SignupBloc>();

    bool isValidForm =
        _formKey.currentState != null && _formKey.currentState!.validate();
    //TextEditingController passwordField = TextEditingController();
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case SignUpInitialState():
            break;
          case SignUpEventState():
            print(state.model);
            break;
          case RegisterErrorState():
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
          case RegisterSuccessState():
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Super!"),
                      content: Text("Registro Exitoso"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => GoRouter.of(context).go("/"),
                            child: const Text("Registro Exitoso")),
                      ],
                    ));
            /*ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registro exitoso'),
                backgroundColor: Colors.green,
              ),
            );
            Timer(
              Duration(seconds: 2),
              () {
                //setState(() {});
              },
            );*/
            //GoRouter.of(context).go("/");
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white.withOpacity(0.9),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Regresar"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    const Text(
                      'Registrarse',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        bloc.add(NameChangedEvent(name: value));
                        isValidForm = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      }),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration: InputDecoration(
                        labelText: 'Nombre Completo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person_add_alt_sharp),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'El nombre es obligatorio' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        bloc.add(
                            IdentificationChangedEvent(identification: value));
                        isValidForm = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      }),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration: InputDecoration(
                        labelText: 'Identificacion',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.credit_score_rounded),
                      ),
                      validator: (value) => validator(
                          SignupMixin.IDENTIFICATION_FIELD,
                          value: value),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        bloc.add(ImageChangedEvent(image: value));
                        isValidForm = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      }),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration: InputDecoration(
                        labelText: 'Imagen',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.insert_emoticon_sharp),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        bloc.add(EmailChangedEvent(email: value));
                        isValidForm = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      }),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) =>
                          validator(SignupMixin.USERNAME_FIELD, value: value),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        bloc.add(PasswordChangedEvent(password: value));
                        isValidForm = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      }),
                      //controller: passwordField,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.security_rounded),
                      ),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) =>
                          validator(SignupMixin.PASSWORD_FIELD, value: value),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.security_rounded),
                      ),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) => validator(
                          SignupMixin.CONFIRM_PASSWORD_FIELD,
                          value: value,
                          compare: state.model.password),
                    ),
                    const SizedBox(height: 25),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.add(SubmitEvent());
                          // Acción al registrar
                          /*
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registro exitoso'),
                                backgroundColor: Colors.green,
                              ),
                            );*/
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class HeaderSignUpWidget extends StatelessWidget {
  const HeaderSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Text(
            'Crear Cuenta',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Regístrate para continuar',
            style: TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
