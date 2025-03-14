import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomePage extends StatelessWidget {
  //const HomePage({super.key});

  /*final List<Product> products = [
    Product(
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOEP2Hxr1AE1mIPER0UzKRlZUcQwvJfEqYTA&s',
      name: 'Producto 1',
      description: 'Descripción del producto 1',
      price: 29.99,
    ),
    Product(
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOEP2Hxr1AE1mIPER0UzKRlZUcQwvJfEqYTA&s',
      name: 'Producto 2',
      description: 'Descripción del producto 2',
      price: 49.99,
    ),
    Product(
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOEP2Hxr1AE1mIPER0UzKRlZUcQwvJfEqYTA&s',
      name: 'Producto 3',
      description: 'Descripción del producto 3',
      price: 19.99,
    ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependecyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60.0), child: AppBarWidget()),
          body: ProductListWidget(),
          /*body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Página de registro"),
                OutlinedButton.icon(
                  onPressed: () {
                    //context.pop();
                     GoRouter.of(context).pop();
                  },
                  label: Text("Ir a iniciar sesión"),
                ),
              ],
            ),
          ),*/
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orangeAccent,
            onPressed: () => GoRouter.of(context).push("/form-product"),
            child: Icon(Icons.add),
          ),
        ),
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
    final bloc = context.read<HomeBloc>();
    return AppBar(
      backgroundColor: Colors.amber,
      title: const Text(
        "Listado de productos",
        style: TextStyle(color: Colors.black87),
      ),
      actions: [
        //SizedBox(width: 12.0,),
        InkWell(
          onTap: () {
            GoRouter.of(context).push("/users");
          },
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
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

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());*/
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      switch (state) {
        case HomeLoadingState || HomeEmptyState() || HomeLoadDataState():
          break;
        case HomeErrorState():
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
        case HomeLoadingState():
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
        case HomeEmptyState():
          return const Center(
            child: Text("No se encontraron productos"),
          );
        case HomeLoadDataState():
          print(state.model.products);
          return ListView.builder(
            itemCount: state.model.products.length,
            itemBuilder: (context, index) => ProductItemWidget(
              product: state.model.products[index],
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

class ProductItemWidget extends StatelessWidget {
  //const ProductItemWidget({super.key});
  final ProductModel product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () => GoRouter.of(context)
            .pushNamed("Form-Product-edit", pathParameters: {"id": product.id}),
        contentPadding: const EdgeInsets.only(
            top: 30.0, bottom: 30.0, left: 15.0, right: 15.0),
        leading: SizedBox(
          height: 150.0,
          width: 150.0, // fixed width and height
          child: Image.network(
              product.urlImage != null && product.urlImage == ""
                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOEP2Hxr1AE1mIPER0UzKRlZUcQwvJfEqYTA&s"
                  : product.urlImage!,
              width: 150,
              height: 150,
              fit: BoxFit.contain),
        ),
        title: Text(product.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(product.description),
            const SizedBox(height: 5),
            Text('\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Eliminar producto"),
                    content: Text("Esta seguro de eliminar ${product.name}?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancelar'),
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () {
                            bloc.add(DeleteProductsEvent(id: product.id));
                            Navigator.pop(context, 'Close');
                          },
                          child: const Text("OK"))
                    ],
                  )),
        ),
        iconColor: Colors.redAccent,
      ),
    );
  }
}
