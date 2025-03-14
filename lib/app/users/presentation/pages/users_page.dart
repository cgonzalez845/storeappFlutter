import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/users/presentation/bloc/users_bloc.dart';
import 'package:storeapp/app/users/presentation/bloc/users_event.dart';
import 'package:storeapp/app/users/presentation/bloc/users_state.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependecyInjection.serviceLocator.get<UsersBloc>(),
        child: Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60.0), child: AppBarWidget()),
            body: Column(
              children: [
                Expanded(child: PersonsListWidget()),
              ],
            )),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return AppBar(
      backgroundColor: Colors.amber,
      title: const Text(
        "Listado de usuarios",
        style: TextStyle(color: Colors.black87),
      ),
      actions: [
        //SizedBox(width: 12.0,),
        InkWell(
          onTap: () {
            bloc.add(LogOutEvent());
          },
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 31.0,
        )
      ],
    );
  }
}

class PersonsListWidget extends StatefulWidget {
  const PersonsListWidget({super.key});

  @override
  State<PersonsListWidget> createState() => _personsListWidgetState();
}

class _personsListWidgetState extends State<PersonsListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());*/
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    bloc.add(GetUsersEvent());
    return BlocConsumer<UsersBloc, UsersState>(listener: (context, state) {
      switch (state) {
        case UsersLoadingState || UsersEmptyState() || UsersLoadDataState():
          break;
        case UsersErrorState():
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Error"),
                    content: const Text("message"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context, "OK"),
                          child: const Text("OK")),
                    ],
                  ));
        case LogoutState():
          GoRouter.of(context).go("/");
          //context.pushReplacementNamed("Home");
          //context.go("/home");
          break;
        default:
      }
    }, builder: (context, state) {
      print(state);
      switch (state) {
        case UsersLoadingState():
          return Center(
            child: Column(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20.0,
                ),
                Text(state.message)
              ],
            ),
          );
        case UsersEmptyState():
          return const Center(
            child: Text("No se encontraron usuarios"),
          );
        case UsersLoadDataState():
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.model.users.map((user) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              Divider(color: Colors.blueAccent),
                              SizedBox(
                                height: 150.0,
                                width: 150.0, // fixed width and height
                                child: Image.network(
                                    user.urlImage != null && user.urlImage == ""
                                        ? "https://media.tenor.com/VvOB8NKGH0IAAAAe/beer-chug.png"
                                        : user.urlImage!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.contain),
                              ),
                              SizedBox(height: 30),
                              Text(user.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.deepPurpleAccent)),
                              SizedBox(height: 10),
                              Text(
                                user.identification,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(user.email,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 5),
                              Text("****",
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.blue,
                          child: Center(
                            child: Text('',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        default:
          return const Center(
            child: Text("no data found"),
          );
      }
    });
  }
}
