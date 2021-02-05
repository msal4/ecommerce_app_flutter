import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jewelry_flutter/bloc/location/location_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';

const _zoom = 15.0;

class MapPage extends StatefulWidget {
  final title = 'locations';
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
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d7ab72"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#888888"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]'''));
  }

  @override
  void initState() {
    _setStyle();
    context.bloc<LocationBloc>().add(FetchLocations());
    super.initState();
  }

  Location _currentLocation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.width / 2;

    return new Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
        if (state is LocationLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is LocationError) {
          return Center(child: Text(state.error.message));
        }

        if (state is LocationsLoaded) {
          final locations = state.locations;
          final currentLocation = _currentLocation ?? locations[0];

          return Container(
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
                                currentLocation.lat,
                                currentLocation.lang,
                              ),
                            ),
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
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
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                enlargeCenterPage: true,
                              ),
                              items: [
                                for (final loc in locations)
                                  GestureDetector(
                                    onTap: () async {
                                      final url =
                                          "https://www.google.com/maps/search/?api=1&query=${currentLocation.lat},${currentLocation.lang}";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(.25),
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
                                        Positioned(
                                          bottom: 15,
                                          right: 15,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: secondaryColor,
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            child: Icon(
                                                Icons.location_on_outlined),
                                          ),
                                        )
                                      ],
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
                                    Text(currentLocation.note),
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
          );
        }
        return SizedBox();
      }),
    );
  }

  moveTo(double latitude, double longitude) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitude, longitude), zoom: _zoom),
    ));
  }
}
