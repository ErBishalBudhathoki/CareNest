import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  Future<void> openMap(
    double latitude,
    double longitude, {
    String? title,
  }) async {
    final request = MapLauncher.marker(
      Location.coords(latitude, longitude, title: title ?? "Destination"),
    );
    final availableMaps = await request.getSupportedMaps(MapApp.all);

    if (availableMaps.isNotEmpty) {
      await availableMaps.first.show();
    } else {
      throw Exception("No map application installed");
    }
  }

  Future<void> openMapWithAddress(String address) async {
    final query = Uri.encodeComponent(address);
    final googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );
    final appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$query");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw Exception("No map application installed");
    }
  }
}

final navigationService = NavigationService();
