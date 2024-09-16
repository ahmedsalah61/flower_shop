import 'package:app_e_commerce/model/item.dart';
import 'package:app_e_commerce/shared/appbar.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Item product;
  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Scafffold,
      appBar: AppBar(
        backgroundColor: apparAndBottom,
        title: const Text(
          "Details screen",
          style: TextStyle(
              color: titleAppbar,
              fontFamily: "myfont",
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: const [ProductsAndPrice()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.product.imgPath,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "\$ ${widget.product.price}",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(
              spacing: 1.0,
              runSpacing: 1.0,
              direction: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 129, 129),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "New",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit_location,
                          color: Colors.green[700],
                          size: 30,
                        ),
                        const Text(
                          "Flower shop",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "myfont",
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Details :",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: "myfont",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs.",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: isShowMore ? 2 : null,
                overflow: TextOverflow.fade,
              ),
            ),
            isShowMore
                ? TextButton(
                    onPressed: () {
                      isShowMore = false;
                      setState(() {});
                    },
                    child: const Text(
                      "Show more",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))
                : TextButton(
                    onPressed: () {
                      isShowMore = true;
                      setState(() {});
                    },
                    child: const Text("Show less",
                        style: TextStyle(
                          fontSize: 20,
                        )))
          ],
        ),
      ),
    );
  }
}
