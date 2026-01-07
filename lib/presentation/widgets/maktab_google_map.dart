import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

class MaktabGoogleMap extends StatefulWidget {
  const MaktabGoogleMap({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<MaktabGoogleMap> createState() => _MaktabGoogleMapState();
}

class _MaktabGoogleMapState extends State<MaktabGoogleMap> {
  late GoogleMapController mapController;
  late double zoom;
  late LatLng addressPosition;
  late OfficeState state;

  @override
  void initState() {
    addressPosition = context.read<OfficeBloc>().state.addressPosition;
    zoom = context.read<OfficeBloc>().state.currentMapZoom;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    state = context.read<OfficeBloc>().state;
    final lat =   state.verifyLicenseNumberModel?.location?.lat;
    final lng = state.verifyLicenseNumberModel?.location?.lng;
    addressPosition = state.addressPosition;
    zoom = context.read<OfficeBloc>().state.currentMapZoom;

    context.read<OfficeBloc>().add(SelectAndGetAddressPositionEvent(
        LatLng(
          lat is num ? lat.toDouble():double.parse(lat),
          lng is num ? lng.toDouble():double.parse(lng),
        ),
        await mapController.getZoomLevel()));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeBloc, OfficeState>(
      listener: (context, state) async {
        // mapController.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       target: LatLng(state.addressPosition.latitude, state.addressPosition.longitude),
        //       zoom: await mapController.getZoomLevel(),
        //     ),
        //   ),
        // );
      },
      builder: (context, state) {
        final lat =   state.verifyLicenseNumberModel?.location?.lat;
        final lng = state.verifyLicenseNumberModel?.location?.lng;
        return Container(
          height: 400.v,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(15.fSize),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.fSize),
            child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Stack(
                      children: [
                        GoogleMap(
                          gestureRecognizers: {
                            Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                            ),
                          },
                          onCameraMove: (position) {
                            addressPosition = position.target;
                          },
                          onCameraIdle: () async {
                            if (addressPosition.latitude != state.addressPosition.latitude ||
                                addressPosition.longitude != state.addressPosition.longitude ||
                                zoom != state.currentMapZoom) {
                              context.read<OfficeBloc>().add(!widget.isEditMode
                                  ? SelectAddressPositionEvent(
                                  LatLng(addressPosition.latitude, addressPosition.longitude),
                                  await mapController.getZoomLevel())
                                  : SelectAndGetAddressPositionEvent(
                                  LatLng(addressPosition.latitude, addressPosition.longitude),
                                  await mapController.getZoomLevel()));
                            }
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: lat!=null && state.verifyLicenseNumberModel != null
                                ? LatLng(
                              lat is num ? lat.toDouble():double.parse(lat),
                              lng is num ? lng.toDouble():double.parse(lng),
                            )
                                : state.addressPosition,
                            // target: state.addressPosition,
                            zoom: zoom,
                          ),
                          myLocationButtonEnabled:  state.officeType == OfficeTypes.request,
                          myLocationEnabled:  state.officeType == OfficeTypes.request,
                          zoomGesturesEnabled:  state.officeType == OfficeTypes.request,
                          scrollGesturesEnabled:  state.officeType == OfficeTypes.request,
                          rotateGesturesEnabled:  state.officeType == OfficeTypes.request,
                          tiltGesturesEnabled:  state.officeType == OfficeTypes.request,
                          // markers: {
                          //   Marker(
                          //     markerId: const MarkerId(''),
                          //     position: LatLng(state.addressPosition.latitude,
                          //         state.addressPosition.longitude),
                          //   )
                          // },
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                          },
                          // onTap: (position) async {
                          //   context.read<OfficeBloc>().add(SelectAddressPositionEvent(
                          //       position, await mapController.getZoomLevel()));
                          // },
                        ),
                        // Positioned(
                        //   bottom: constraints.maxHeight * 0.05,
                        //   right: constraints.maxWidth * 0.05,
                        //   child: InkWell(
                        //     onTap: () async {
                        //       context
                        //           .read<OfficeBloc>()
                        //           .add(GoToCurrentLocationEvent(await mapController.getZoomLevel()));
                        //     },
                        //     child: Container(
                        //       width: 60.v,
                        //       height: 60.h,
                        //       decoration: const BoxDecoration(
                        //         color: Color(0xffffffff),
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: Icon(
                        //         Icons.my_location,
                        //         color: const Color(0xFF14B183),
                        //         size: 45.fSize,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Icon(
                      Icons.my_location,
                      color: AppColors.cherryRed,
                      size: 45.fSize,
                    )
                  ],
                )),
          ),
        );
      }
    );
  }
}
