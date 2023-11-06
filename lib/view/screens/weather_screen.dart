import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapp/utils/utils.dart';

import '../../data/response/status.dart';
import '../../model/weather_model.dart';
import '../../shared/widgets/drawer/drawer_widget.dart';
import '../../shared/widgets/error_screen.dart';
import '../../view_model/theme/theme_view_model.dart';
import '../../view_model/weather_view_model.dart';
import '../components/list_item_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherViewModel>().localOrApiData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Weather App",
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: Consumer2<WeatherViewModel, ThemeViewModel>(
              builder: (context, weatherViewModel, theme, _) {
                switch (weatherViewModel.response.status) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.error:
                    return ErrorScreen(
                        errorText: weatherViewModel.response.message!);
                  case Status.completed:
                    WeatherModel weatherModel = weatherViewModel.response.data!;
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: context.w,
                            height: context.h * 0.2,
                            // color: Colors.grey,
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "current weather",
                                  style: context.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: context.h * 0.02,
                                ),
                                Text(
                                  "${weatherModel.current.temp} °C",
                                  style: context.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: context.h * 0.02,
                                ),
                                Text(
                                  context
                                      .watch<WeatherViewModel>()
                                      .locationName,
                                  style: context.bodyMedium
                                      .copyWith(fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "7 days weather forecast",
                                style: context.bodySmall,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () {
                                return weatherViewModel.refresh(context);
                              },
                              child: SizedBox(
                                height: 70,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    Daily daily = weatherModel.daily[index];
                                    return ListItemWidget(
                                      daily: daily,
                                      theme: theme,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: context.h * 0.02,
                                    );
                                  },
                                  itemCount: 7,
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
