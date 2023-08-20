import 'package:e_commerce/common/loader.dart';
import 'package:e_commerce/features/home/service/home_services.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

import '../../features/product_details/screens/product_details_screen.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 10, bottom: 12),
                    child: const Text(
                      'Deal of the day',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Image.network(
                    product!.images[0],
                    height: 200,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '\$100',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding:
                        const EdgeInsets.only(left: 15, top: 5, right: 40),
                    child: const Text(
                      'Basit',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      onTap: navigateToDetailScreen,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                              fit: BoxFit.fill,
                              width: 200,
                              height: 120,
                            ),
                          )
                              .toList(),
                        )
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ).copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}
