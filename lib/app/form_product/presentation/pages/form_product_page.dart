import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_mixin.dart';

class FormProductPage extends StatelessWidget {
  final String? id;

  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependecyInjection.serviceLocator.get<FormProductBloc>(),
      //value: FormProductBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(id == null ? "Agregar Producto" : "Actualizar producto"),
        ),
        body: Column(
          children: [
            FormProductWidget(id),
          ],
        ),
      ),
    );
  }
}

class FormProductWidget extends StatefulWidget {
  final String? id;
  const FormProductWidget(this.id, {super.key});

  @override
  State<FormProductWidget> createState() => _FormProductWidgetState();
}

class _FormProductWidgetState extends State<FormProductWidget>
    with FormProductMixin {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();

    if (widget.id != null) {
      bloc.add(GetProductEvent(widget.id!));
    }
    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController urlField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            //Navigator.pop(context, "Back");
            break;
          case SubmitErrorState():
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          urlField.text = state.model.urlImage;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Text(state.model.name),
                    TextFormField(
                      controller: nameField,
                      onChanged: (value) =>
                          bloc.add(NameChangedEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Name:",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Escribe el nombre del producto",
                      ),
                      //keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      controller: urlField,
                      onChanged: (value) =>
                          bloc.add(UrlImageChangedEvent(urlImage: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Url:",
                        icon: Icon(Icons.image),
                        hintText: "Escribe la url del producto",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: priceField,
                      onChanged: (value) =>
                          bloc.add(PriceChangedEvent(price: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Precio:",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escribe el precio del producto",
                      ),
                    ),
                    SizedBox(height: 48.0),
                    FilledButton(
                      onPressed: () => {bloc.add(SubmitEvent())},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(widget.id != null ? "Guardar" : "Crear",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          // switch (state) {
          //   case DataUpdateState():
          //     print(state.model.email);
          //     break;

          //   default:
          // }
          // return Expanded(
          //   child: Container(
          //     color: Colors.amber,
          //     child: InkWell(child: Text("data"), onTap: () {
          //       bloc.add(EmailChangedEvent(email: "Cambio de email"));
          //     }),
          //   ),
          // );
        },
      ),
    );
  }
}
