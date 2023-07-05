
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:e_commerce/features/admin/models/sales.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductsChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
