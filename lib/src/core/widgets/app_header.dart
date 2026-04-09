import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/home/bloc/dashboard_bloc.dart';

class KutootHeader extends StatelessWidget {
  const KutootHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0), // Very light orange
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Color(0xFFE67E22)),
                SizedBox(width: 4),
                BlocConsumer<DashboardBloc, DashboardState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Text(
                      state.isFetchingLocation
                          ? 'LOCATING...'
                          : (state.currentLocation?.toUpperCase() ??
                                'SELECT LOCATION'),
                      style: TextStyle(
                        color: Color(0xFFE67E22),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
                Icon(Icons.arrow_drop_down, size: 18, color: Color(0xFFE67E22)),
              ],
            ),
          ),

          Image.network(
            'https://www.kutoot.com/images/landingpage/kutoot-logo.png',
            height: 30,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'KUTOOT',
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFA12B3F),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA12B3F).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'UPGRADE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
