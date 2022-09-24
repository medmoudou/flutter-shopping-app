import 'package:api/models/cart_model.dart';
import 'package:api/models/product_model.dart';
import 'package:api/pages/details.dart';
import 'package:api/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _MainState();
}

class _MainState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    String searchTxt;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
        ),
        backgroundColor: const Color.fromRGBO(11, 1, 141, 1),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () => Navigator.pop(context),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<CartModel>(builder: (context, cart, child) {
                if (cart.length > 0) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    shrinkWrap: true,
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cart.productsList[index].title),
                        leading: Image.network(
                          cart.productsList[index].thumbnail,
                          width: 80,
                          fit: BoxFit.cover,
                          height: 60,
                        ),
                        trailing: Text(
                            cart.productsList[index].price.toString() + ' €'),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Cart is empty'),
                  );
                }
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () {
                        var item = context.read<CartModel>();
                        item.removeAll();
                      },
                      child: const Text(
                        "Clear ",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text('Total price: ${cart.total} €');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
