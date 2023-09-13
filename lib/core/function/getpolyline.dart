import 'dart:convert';

import 'package:delivery/core/constant/color.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future getPolyline(lat, long, destlat, destlong) async {
  List<LatLng> polylineco = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polylineset = {};
  var url =
      "https://maps.googleapis.com/maps/api/directions/json?destination=$destlat,$destlong&origin=$lat,$long&key=AIzaSyB5mTl0KQnvcRuWMp9ROdcKGDQNbSUcULw";
  var response = await http.post(Uri.parse(url));
  var responsebody = jsonDecode(response.body);
  print("================${lat}============");
  var point = responsebody['routes'][0]['overview_polyline']['points'];
  print("point${point}");
  List<PointLatLng> result = polylinePoints.decodePolyline(point);
  if (result.isNotEmpty) {
    result.forEach((PointLatLng pointLatLng) {
      polylineco.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
    });
  }
  Polyline polyline = Polyline(
      polylineId: PolylineId("Amr"),
      color: AppColor.favoritecolor,
      width: 5,
      points: polylineco);
  polylineset.add(polyline);
return polylineset;
}
