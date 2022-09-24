import 'package:api/models/cart_model.dart';
import 'package:api/models/product_model.dart';
import 'package:api/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Store',
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
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(product.images[0]),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Text(
                            product.price.toString() + ' €',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      product.brand,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.category,
                              style: const TextStyle(fontSize: 16),
                            ),
                            SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: double.parse(product.rating.toString()),
                                size: 25.0,
                                isReadOnly: true,
                                color: Colors.red,
                                borderColor: Colors.black,
                                spacing: 1.0)
                          ]),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(11, 1, 141, 1)),
                        onPressed: () {
                          var item = context.read<CartModel>();
                          item.addToCart(product);
                        },
                        child: const Text('Add to cart'),
                      ),
                    )
                  ]),
            ),
          )),
    );
  }
}
