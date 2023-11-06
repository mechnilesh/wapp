import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wapp/utils/utils.dart';

import '../../model/weather_model.dart';
import '../../view_model/theme/theme_view_model.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.daily,
    required this.theme,
  });

  final Daily daily;
  final ThemeViewModel theme;

  @override
  Widget build(BuildContext context) {
    //     int timestamp = 1699162200;
    // DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
    return Container(
      padding: const EdgeInsets.all(10),
      height: 20,
      decoration: BoxDecoration(
        color: theme.isDark
            ? Colors.purple.withOpacity(0.3)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${daily.temp.day}°C",
            style: context.bodyMedium.copyWith(fontSize: 14),
          ),
          Text(
            DateFormat('EEEE')
                .format(
                  DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000),
                )
                .substring(0, 3),
            style: context.bodyMedium.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
