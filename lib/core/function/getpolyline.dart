import 'dart:convert';

import 'package:delivery/core/config/app_config.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future getPolyline(lat, long, destlat, destlong) async {
  final polylineCoordinates = <LatLng>[];
  final polylinePoints = PolylinePoints();
  final polylines = <Polyline>{};
  if (AppConfig.googleMapsApiKey.isEmpty) {
    return polylines;
  }

  final url =
      "https://maps.googleapis.com/maps/api/directions/json?destination=$destlat,$destlong&origin=$lat,$long&key=${AppConfig.googleMapsApiKey}";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return polylines;
  }

  final responseBody = jsonDecode(response.body);
  final routes = responseBody['routes'] as List<dynamic>?;
  if (routes == null || routes.isEmpty) {
    return polylines;
  }

  final points = routes.first['overview_polyline']?['points'] as String?;
  if (points == null || points.isEmpty) {
    return polylines;
  }

  final result = polylinePoints.decodePolyline(points);
  if (result.isNotEmpty) {
    for (final point in result) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }
  }
  polylines.add(
    Polyline(
      polylineId: const PolylineId('delivery-route'),
      color: AppColor.favoritecolor,
      width: 5,
      points: polylineCoordinates,
    ),
  );
  return polylines;
}
