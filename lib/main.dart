import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter with Maps',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple[300],
        colorScheme: ThemeData().colorScheme.copyWith(
          secondary: Colors.purple[600],
        ),
      ),
      home: const Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final _mapController = Completer<GoogleMapController>();

  final _initialPosition = const CameraPosition(
    target: LatLng(-20.28224, -50.24638),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter with Maps'),
        backgroundColor: Colors.purple[300], // cor lilás para o AppBar
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.location_on), // Ícone de localização
            onPressed: () {
              // Aqui você pode definir uma ação para quando o ícone for clicado
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) {
          _mapController.complete(controller);
        },
        mapType: MapType.normal,
        onTap: (coordenadas) async {
          (await _mapController.future)
              .animateCamera(CameraUpdate.newLatLng(coordenadas));
        },
        markers: {
          const Marker(
            markerId: MarkerId('marker_id'),
            position: LatLng(-20.28224, -50.24638),
            infoWindow: InfoWindow(
              title: 'Localização Desejada',
              snippet: 'Ao clicar no "Marker", isto será exibido',
            ),
          ),
        },
      ),
    );
  }
}
