import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoassessment/src/core/app_styles.dart';
import 'package:lingoassessment/src/models/product_model.dart';
import 'package:lingoassessment/src/screens/products_display_screen/products_display_screen_vm.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';

class ProductsDisplayScreen extends StatefulWidget {
  const ProductsDisplayScreen({super.key});

  @override
  State<ProductsDisplayScreen> createState() => _ProductsDisplayScreenState();
}

class _ProductsDisplayScreenState extends State<ProductsDisplayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productsVM =
          Provider.of<ProductsDisplayScreenViewModel>(context, listen: false);
      productsVM.fetchProductsFromApi(context);
      productsVM.fetchShowDiscountedPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.whiteColor,
      appBar: const CustomAppBar(
        text: 'e-Shop',
        appBarColor: AppStyles.blueColor,
        textColor: AppStyles.whiteColor,
      ),
      body: Consumer<ProductsDisplayScreenViewModel>(
        builder: (context, productsDisplayScreenVM, child) {
          if (productsDisplayScreenVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 15) / 2;
                    return Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: productsDisplayScreenVM.products.map((product) {
                        final bool showDiscounted =
                            productsDisplayScreenVM.showDiscountedPrice;
                        final price = showDiscounted
                            ? product.getDiscountedPrice()
                            : product.price;

                        return Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              product.images != null &&
                                      product.images!.isNotEmpty
                                  ? Image.network(
                                      product.images![0],
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 100,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: const Icon(Icons.image,
                                          color: Colors.white),
                                    ),
                              const SizedBox(height: 8),
                              Text(
                                product.title ?? 'No title',
                                style: GoogleFonts.poppins(
                                  fontWeight: AppFontWeight.boldFont,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.description ?? 'No description',
                                style: GoogleFonts.poppins(
                                  fontWeight: AppFontWeight.regularFont,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '\$${product.price?.toStringAsFixed(2) ?? "N/A"}',
                                       overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        decoration: showDiscounted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                 
                                  if (showDiscounted)
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '\$${price?.toStringAsFixed(2) ?? "N/A"}',
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                          
                                          fontWeight: AppFontWeight.regularFont,
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  Text(
                                    '${product.discountPercentage?.toStringAsFixed(0)}% off',
                                    style: GoogleFonts.poppins(
                                      fontWeight: AppFontWeight.regularFont,
                                      fontSize: 10,
                                      color: const Color(0xff0FFF50),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
