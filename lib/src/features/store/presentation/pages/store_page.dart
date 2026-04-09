import 'package:flutter/material.dart';
import 'package:my_app/src/core/widgets/app_header.dart';
import 'package:my_app/src/core/widgets/search_bar.dart';

import '../widgets/category_chip.dart';
import '../widgets/store_card.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              KutootHeader(),
              SearchBarWidget(),
              CategoryChips(),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .55,
                  crossAxisSpacing: 10,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return StoreCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
