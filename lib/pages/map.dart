import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';

const _zoom = 20.0;

final locationsJson = [
  {
    "idLocation": 1,
    "lat": "33.31693755657479",
    "lang": "44.354765301920764",
    "storeImage": "http://dashboard.hayderalkhafaje.com/images/J3t3i3I3O3.png",
    "note": "jhasbdhabsd",
    "noteEn": "ajhsbdhasbd"
  },
  {
    "idLocation": 2,
    "lat": "33.308825781567045",
    "lang": "44.34028684347654",
    "storeImage":
        "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80",
    "note": "djlsfj 1",
    "noteEn": "sdjfs 1"
  },
  {
    "idLocation": 2,
    "lat": "33.30807260636624",
    "lang": "44.34653102600935",
    "storeImage":
        "https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80",
    "note": "skdjf 2",
    "noteEn": "sdfjlsd 2"
  }
];

final locations = locationsJson.map((e) => Location.fromMap(e)).toList();

class MapPage extends StatefulWidget {
  final title = 'MAP';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  _setStyle() {
    _controller.future.then((value) => value.setMapStyle('''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]'''));
  }

  @override
  void initState() {
    _setStyle();
    super.initState();
  }

  Location _currentLocation = locations[0];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.width / 2;

    return new Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 120,
                  child: Stack(
                    children: [
                      GoogleMap(
                        markers: locations
                            .map((l) => Marker(
                                markerId: MarkerId(l.idLocation.toString()),
                                position: LatLng(l.lat, l.lang)))
                            .toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          zoom: _zoom,
                          target: LatLng(
                              _currentLocation.lat, _currentLocation.lang),
                        ),
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      Positioned(
                        bottom: 45,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: horizontalGradient,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final url =
                                  "https://www.google.com/maps/search/?api=1&query=${_currentLocation.lat},${_currentLocation.lang}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                SizedBox(width: 10),
                                Text(
                                  'OPEN IN MAP',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 75),
              ],
            ),
            Column(
              children: [
                Spacer(flex: 110),
                Flexible(
                  flex: 90,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: ListView(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (i, reason) {
                              final loc = locations[i];
                              setState(() {
                                _currentLocation = loc;
                              });

                              moveTo(loc.lat, loc.lang);
                            },
                            viewportFraction: 0.9,
                            height: height,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enlargeCenterPage: true,
                          ),
                          items: [
                            for (final loc in locations)
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(.25),
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 10),
                                child: Image.network(
                                  loc.storeImage,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                          ],
                        ),
                        AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text(_currentLocation.note),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  moveTo(double latitude, double longitude) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitude, longitude), zoom: _zoom),
    ));
  }
}