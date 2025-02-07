import 'package:app_e_commerce/pages/checkout.dart';
import 'package:app_e_commerce/provider/cart.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 24,
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(211, 164, 255, 193),
                      shape: BoxShape.circle),
                  child: Text(
                    "${carttt.itemCount}",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                  )),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(),
                  ),
                );
              },
              icon: Icon(
                Icons.add_shopping_cart,
                color: titleAppbar,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            "\$ ${carttt.price}",
            style: TextStyle(fontSize: 20, color: titleAppbar),
          ),
        ),
      ],
    );
  }
}
