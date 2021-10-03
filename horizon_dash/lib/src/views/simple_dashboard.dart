import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:horizon_client/horizon_client.dart';
import 'package:horizon_dash/src/settings/settings_controller.dart';

class SimpleDashboard extends StatefulWidget {
  final HorizonClient client;

  const SimpleDashboard({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _SimpleDashboardState createState() => _SimpleDashboardState();
}

class _SimpleDashboardState extends State<SimpleDashboard> {
  List<Color> rpmGradient = const [
    Colors.blue,
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<HorizonDataFrame>(
        stream: widget.client.telemetryStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildMain(context, snapshot.data!);
          }
        },
      ),
    );
  }

  String secondsToTimestamp(double time) {
    var hours = time ~/ 3600;
    var minutes = time ~/ 60 % 60;
    var seconds = time % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toStringAsFixed(2).padLeft(5, '0')}';
  }

  Widget _buildMain(BuildContext context, HorizonDataFrame frame) {
    // Prefetch now so we don't keep computing this.
    var frameList = frame.asMap.entries.toList(growable: false);
    var rpmPercentage =
        (frame.currentEngineRpm / frame.engineMaxRpm).clamp(0.0, 1.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            LinearProgressIndicator(
              value: rpmPercentage,
              minHeight: 150,
              color: Color.lerp(Colors.blue, Colors.red,
                  ((rpmPercentage - 0.5) * 2).clamp(0.0, 1.0)),
            ),
            Container(
              child: Text(
                'Gear: ${(frame.gear == 0) ? 'R' : frame.gear}',
                style: Theme.of(context).textTheme.headline3,
              ),
              height: 150,
              alignment: Alignment.bottomRight,
            ),
            Center(
              child: Text(
                '${(frame.speed * 2.237).round()} mph',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
        // const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LargeLabel('Best lap time', secondsToTimestamp(frame.bestLap)),
            LargeLabel(
                'Current lap time', secondsToTimestamp(frame.currentLap)),
            LargeLabel(
                'Total race time', secondsToTimestamp(frame.currentRaceTime)),
            LargeLabel('Position', '${frame.racePosition}/12'),
            LargeLabel('Lap', '${frame.lapNumber}/3')
          ],
        ),
        const Spacer(),
        Expanded(
          child: ListView(
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 2.75,
                ),
                itemCount: frameList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var title = frameList[index].key;
                  var value = frameList[index].value;
                  if (value.runtimeType == double) {
                    value = (value as double).toStringAsFixed(2);
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '$value',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFeatures: [const FontFeature.tabularFigures()]),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Column LargeLabel(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Text(value, style: Theme.of(context).textTheme.headline3!.copyWith(fontFeatures: [const FontFeature.tabularFigures()])),
      ],
    );
  }
}
