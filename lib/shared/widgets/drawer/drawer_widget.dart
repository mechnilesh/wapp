import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapp/utils/utils.dart';
import 'package:wapp/view_model/theme/theme_view_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
      return Drawer(
        // width: context.w * 0.8,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              child: Text("Weather App", style: context.bodyMedium),
            ),
            SwitchListTile.adaptive(
              value: themeViewModel.isDark,
              onChanged: themeViewModel.toggleTheme,
              title: Text(themeViewModel.isDark ? "dark_mode" : "light_mode",
                  style: context.bodySmall),
            ),
            // Container(
            //color: Colors.indigo,
            // height: context.h * 0.08,
            // margin: const EdgeInsets.only(top: 20),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         width: context.w * 0.25,
            //         decoration: BoxDecoration(
            //           color: themeViewModel.isDark
            //               ? Colors.deepPurple.withOpacity(0.4)
            //               : Colors.grey,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         alignment: Alignment.center,
            //         child: Text(
            //           "ENGLISH",
            //           style: context.bodySmall.copyWith(
            //               fontWeight: FontWeight.bold,
            //               fontStyle: FontStyle.italic),
            //         ),
            //       ),
            //     ),
            // GestureDetector(
            //   onTap: () {
            //     "hi";
            //   },
            //   child: Container(
            //     width: context.w * 0.25,
            //     decoration: BoxDecoration(
            //       color: themeViewModel.isDark
            //           ? Colors.deepPurple.withOpacity(0.4)
            //           : Colors.grey,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "हिंदी",
            //       style: context.bodySmall.copyWith(
            //           fontWeight: FontWeight.bold,
            //           fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
