import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(product.productName),
            content: Text(product.productDescription),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
            ],
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product.coverImg, width: 55, height: 55, fit: BoxFit.cover),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                        product.productName,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('\$${product.productPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}