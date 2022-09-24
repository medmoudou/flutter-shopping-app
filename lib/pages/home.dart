import 'package:api/models/cart_model.dart';
import 'package:api/models/product_model.dart';
import 'package:api/pages/cart.dart';
import 'package:api/pages/details.dart';
import 'package:api/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    String searchTxt;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Store',
          ),
          backgroundColor: const Color.fromRGBO(11, 1, 141, 1),
          leading: GestureDetector(
            child: const Icon(
              Icons.menu,
            ),
          ),
          actions: <Widget>[
            ButtonBar(
              children: [
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Text(' ${cart.length}');
                  },
                ),
                IconButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cart()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            )
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: productService.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<Product>;
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(),
                          settings: RouteSettings(
                            arguments: data[index],
                          ),
                        ),
                      ),
                      title: Text(data[index].title!),
                      leading: Image.network(
                        data[index].thumbnail,
                        width: 80,
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      subtitle: Text(data[index].brand),
                      trailing: Text(data[index].price.toString() + ' €'),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
