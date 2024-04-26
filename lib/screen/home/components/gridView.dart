import 'package:flutter/material.dart';
// import 'package:travelup/variables.dart';
// import 'package:travelup/widget/zone/zone.dart';

class GridZone extends StatefulWidget {
  const GridZone({Key? key}) : super(key: key);

  @override
  State<GridZone> createState() => _GridZoneState();
}

class _GridZoneState extends State<GridZone> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  //itemCount: demoZones.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    //return Zone(ZoneModel: demoZones[index],);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}