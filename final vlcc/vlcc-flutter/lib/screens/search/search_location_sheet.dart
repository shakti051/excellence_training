import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/widgets/custom_text_field.dart';

class SearchLocationSheet extends StatefulWidget {
  final void Function(Place) callback;

  const SearchLocationSheet({Key? key, required this.callback})
      : super(key: key);

  @override
  _SearchLocationSheetState createState() => _SearchLocationSheetState();
}

class _SearchLocationSheetState extends State<SearchLocationSheet> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchTextController.dispose();
  }

  final sessionToken = Uuid().v4();
  late PlaceApiProvider apiClient;

  @override
  void initState() {
    super.initState();
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a location'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
              ))
        ],
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                fillColor: AppColors.greyBackground,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    SVGAsset.searchIcon,
                    color: Colors.grey,
                  ),
                ),
                isPrefixIcon: true,
                isReadOnly: false,
                isSuffixIcon: true,
                suffixIcon: _searchTextController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _searchTextController.text = '';
                        },
                        child: Icon(Icons.clear_rounded, color: Colors.black54),
                      )
                    : SizedBox(),
                customField: CustomField.input,
                textEditingController: _searchTextController,
                textFormatter: [LengthLimitingTextInputFormatter(50)],
                hintText: 'Search for area, street name ...',
                ontap: () {},
                onChanged: (value) {
                  setState(() {});
                },
              ),
              FutureBuilder(
                  future: apiClient.fetchSuggestions(_searchTextController.text,
                      Localizations.localeOf(context).languageCode),
                  builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) {
                    Widget child = SizedBox();
                    if (snapshot.hasData) {
                      child = ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title:
                                  Text(snapshot.data?[index].description ?? ''),
                              onTap: () async {
                                Place place =
                                    await apiClient.getPlaceDetailFromId(
                                        snapshot.data?[index].placeId ?? '');
                                widget.callback(place);
                                Navigator.pop(context);
                              },
                            );
                          });
                    } else {
                      // child = SizedBox(child: Text('Loading...'));
                    }

                    return child;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Place {
  String streetNumber;
  String state;
  String city;
  String zipCode;
  double latitude;
  double longitude;

  Place({
    required this.streetNumber,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
  });
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Services();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;
  final String apiKey = 'AIzaSyCJ1HGjRHt15_gyI0fLho4T9hsF7TaOTZE';
  // static final String androidKey = 'YOUR_API_KEY_HERE';
  // static final String iosKey = 'YOUR_API_KEY_HERE';
  // final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    // http.Response response;
    //  = await client.get(request);
    List<Suggestion> suggestions = [];
    // try {
    final response = await http.get(
      Uri.parse(request),
    );
    // var body = _returnResponse(response, 'Get API');
    // return body;
    // } catch (error) {
    // log('Maps Error', error: error);
    // }

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list

        suggestions = result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
        return suggestions;
      }
      if (result['status'] == 'ZERO_RESULTS') {
        suggestions.add(Suggestion('', 'No result found'));
        return suggestions;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken';
    // final response = await client.get(request);
    final response = await http.get(
      Uri.parse(request),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final geometry = result['result']['geometry']['location'];
        final latitude = geometry['lat'] ?? 0;
        final longitude = geometry['lng'] ?? 0;
        final place = Place(
          city: '',
          streetNumber: '',
          zipCode: '',
          state: '',
          latitude: latitude,
          longitude: longitude,
        );

        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.state = c['long_name'];
          }
          if (type.contains('administrative_area_level_2')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
