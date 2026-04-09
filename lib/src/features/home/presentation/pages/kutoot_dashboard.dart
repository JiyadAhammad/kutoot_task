import 'package:flutter/material.dart';
import 'package:my_app/src/core/widgets/search_bar.dart';

import '../../../../core/widgets/app_header.dart';
import '../../../store/presentation/pages/store_page.dart';
import '../widgets/category_list.dart';
import '../widgets/fashion_sale.dart';
import '../widgets/store_header.dart';
import '../widgets/store_near_by_card.dart';
import '../widgets/weekly_reward.dart';

class KutootDashboard extends StatefulWidget {
  const KutootDashboard({super.key});

  @override
  State<KutootDashboard> createState() => _KutootDashboardState();
}

class _KutootDashboardState extends State<KutootDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Stores"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KutootHeader(),

                const SizedBox(height: 16),
                SearchBarWidget(),
                const SizedBox(height: 16),
                const FashionSaleCard(),
                const SizedBox(height: 16),
                const CategoryList(),
                const SizedBox(height: 16),
                StoreHeader(
                  title: "Stores Nearby",
                  onSeeAllTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => StoresPage()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                StoresNearByCard(),
                StoresNearByCard(),
                const SizedBox(height: 10),
                StoreHeader(title: "Weekly Rewards", onSeeAllTap: () {}),

                WeeklyRewardCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
