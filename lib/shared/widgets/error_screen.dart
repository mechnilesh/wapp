import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapp/utils/utils.dart';

import '../../utils/enums.dart';
import '../../view_model/weather_view_model.dart';

class ErrorScreen extends StatelessWidget {
  final String errorText;

  const ErrorScreen({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            errorText,
            textAlign: TextAlign.center,
            onTap: () {
              // you can show toast to the user, like "Copied"
              context.snowSnackBar(
                "Copied",
                type: SnackBarTypeEnum.success,
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.read<WeatherViewModel>().refresh(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(context.w * 0.3, context.h * 0.05),
            ),
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
