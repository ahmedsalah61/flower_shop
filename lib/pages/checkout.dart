import 'package:app_e_commerce/provider/cart.dart';
import 'package:app_e_commerce/shared/appbar.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final cart2 = Provider.of<Cart>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Scafffold,
      appBar: AppBar(
        backgroundColor: apparAndBottom,
        title: const Text(
          "Checkout",
          style: TextStyle(
              color: titleAppbar,
              fontFamily: "myfont",
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        actions: const [ProductsAndPrice()],
      ),
      body: Column(children: [
        SingleChildScrollView(
          child: SizedBox(
            height: 550,
            child: ListView.builder(
                itemCount: cart2.selectedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      subtitle:
                          Text(" \$ ${cart2.selectedProducts[index].price}"),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(cart2.selectedProducts[index].imgPath),
                      ),
                      title: Text(" ${cart2.selectedProducts[index].name}"),
                      trailing: IconButton(
                          onPressed: () {
                            cart2.delete(cart2.selectedProducts[index]);
                          },
                          icon: const Icon(Icons.settings_remote_sharp)),
                    ),
                  );
                }),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(apparAndBottom),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
          child: Text(
            "Pay \$${cart2.price}",
            style: const TextStyle(fontSize: 25, color: titleAppbar),
          ),
        ),
      ]),
    ));
  }
}
