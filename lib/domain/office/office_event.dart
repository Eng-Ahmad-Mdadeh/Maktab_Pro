// ignore_for_file: must_be_immutable

part of 'office_bloc.dart';

enum OfficeTypes { none, license, request }

enum VisibilityStates { show, hide }

enum ToggleStates { on, off }

enum AdertiserRelationshipOptions { none, owner, agent, marketer }

enum MarketerTypes { none, exclusive, notExclusive }

enum UnitPriceOptions { hourly, daily, monthly, yearly }

enum DepositTypes { price, percentage }

enum MarketerFileTypes { officeLicense, buildingLicense, civilDefense }

enum StepNavigationState { initial, next, previous, end }

enum OfficeApiCallState { initial, loading, success, failure }

sealed class OfficeEvent extends Equatable {
  const OfficeEvent();

  @override
  List<Object> get props => [];
}

final class AddLicensedOfficeEvent extends OfficeEvent {}

final class SetLicenseNumberEvent extends OfficeEvent {
  final String licenseNumber;

  const SetLicenseNumberEvent(this.licenseNumber);
}

final class AddMarketingRequestEvent extends OfficeEvent {}

final class SetOfficeNameEvent extends OfficeEvent {
  final String name;

  const SetOfficeNameEvent(this.name);
}

final class SelectCategoryEvent extends OfficeEvent {
  final int id;

  const SelectCategoryEvent(this.id);
}

final class ToggleAccepingUserAgreementEvent extends OfficeEvent {}

final class SelectAdertiserRelationshipEvent extends OfficeEvent {
  final AdertiserRelationshipOptions option;

  const SelectAdertiserRelationshipEvent(this.option);
}

final class SelectMarketerTypeEvent extends OfficeEvent {
  final MarketerTypes option;

  const SelectMarketerTypeEvent(this.option);
}

final class SetSpaceEvent extends OfficeEvent {
  final String space;

  const SetSpaceEvent(this.space);
}

final class SetEquipmentEvent extends OfficeEvent {
  final String? equipment;

  const SetEquipmentEvent(this.equipment);
}

final class SetTypeEvent extends OfficeEvent {
  final String type;

  const SetTypeEvent(this.type);
}

final class IncreaseFloorEvent extends OfficeEvent {
  int floor;

  IncreaseFloorEvent(this.floor);
}

final class DecreaseFloorEvent extends OfficeEvent {
  int floor;

  DecreaseFloorEvent(this.floor);
}

final class IncreaseOfficeAgeEvent extends OfficeEvent {
  int age;

  IncreaseOfficeAgeEvent(this.age);
}

final class DecreaseOfficeAgeEvent extends OfficeEvent {
  int age;

  DecreaseOfficeAgeEvent(this.age);
}

final class ToggleOfficesCountSelectorEvent extends OfficeEvent {}

final class IncreaseOfficesCountEvent extends OfficeEvent {
  int count;

  IncreaseOfficesCountEvent(this.count);
}

final class DecreaseOfficesCountEvent extends OfficeEvent {
  int count;

  DecreaseOfficesCountEvent(this.count);
}

final class ToggleMeetingRoomsCountSelectorEvent extends OfficeEvent {}

final class IncreaseMeetingRoomsCountEvent extends OfficeEvent {
  int count;

  IncreaseMeetingRoomsCountEvent(this.count);
}

final class DecreaseMeetingRoomsCountEvent extends OfficeEvent {
  int count;

  DecreaseMeetingRoomsCountEvent(this.count);
}

final class ToggleTablesCountSelectorEvent extends OfficeEvent {}

final class IncreaseTablesCountEvent extends OfficeEvent {
  int count;

  IncreaseTablesCountEvent(this.count);
}

final class DecreaseTablesCountEvent extends OfficeEvent {
  int count;

  DecreaseTablesCountEvent(this.count);
}

final class ToggleSharedWorkSpacesSelectorEvent extends OfficeEvent {}

final class IncreaseSharedWorkSpacesCountEvent extends OfficeEvent {
  int count;

  IncreaseSharedWorkSpacesCountEvent(this.count);
}

final class DecreaseSharedWorkSpacesCountEvent extends OfficeEvent {
  int count;

  DecreaseSharedWorkSpacesCountEvent(this.count);
}

final class SelectFacilityEvent extends OfficeEvent {
  int id;

  SelectFacilityEvent(this.id);
}

final class SetDescriptionEvent extends OfficeEvent {
  final String description;

  const SetDescriptionEvent(this.description);
}

final class SelectFeatureEvent extends OfficeEvent {
  int id;

  SelectFeatureEvent(this.id);
}

final class SelectServiceEvent extends OfficeEvent {
  int id;

  SelectServiceEvent(this.id);
}

final class SelectComfortEvent extends OfficeEvent {
  int id;

  SelectComfortEvent(this.id);
}

final class AddAddtionalServiceEvent extends OfficeEvent {}

final class RemoveAdditionalServiceEvent extends OfficeEvent {
  Key key;

  RemoveAdditionalServiceEvent(this.key);
}

final class SetServiceNameEvent extends OfficeEvent {
  final Key key;
  final String name;

  const SetServiceNameEvent(this.key, this.name);
}

final class SetServiceEnglishNameEvent extends OfficeEvent {
  final Key key;
  final String name;

  const SetServiceEnglishNameEvent(this.key, this.name);
}

final class SetServicePriceEvent extends OfficeEvent {
  final Key key;
  final String price;

  const SetServicePriceEvent(this.key, this.price);
}

final class ToggleServiceStateEvent extends OfficeEvent {
  final Key key;

  const ToggleServiceStateEvent(this.key);
}

final class SelectAddressPositionEvent extends OfficeEvent {
  LatLng position;
  double zoom;

  SelectAddressPositionEvent(this.position, this.zoom);
}

final class GoToCurrentLocationEvent extends OfficeEvent {
  double zoom;

  GoToCurrentLocationEvent(this.zoom);
}

final class GoToSelectedAddressEvent extends OfficeEvent {
  String placeId;

  GoToSelectedAddressEvent(this.placeId);
}

final class GetOfficeAddressDetailsEvent extends OfficeEvent {}

final class SetCityNameEvent extends OfficeEvent {
  String name;

  SetCityNameEvent(this.name);
}

final class SetNeighborhoodNameEvent extends OfficeEvent {
  String name;

  SetNeighborhoodNameEvent(this.name);
}

final class SetStreetNameEvent extends OfficeEvent {
  String name;

  SetStreetNameEvent(this.name);
}

final class SetInterfaceEvent extends OfficeEvent {
  final String interface;

  const SetInterfaceEvent(this.interface);
}

final class ToggleUnitPriceOptionEvent extends OfficeEvent {
  UnitPriceOptions option;

  ToggleUnitPriceOptionEvent(this.option);
}

final class ChangeUnitPriceEvent extends OfficeEvent {
  UnitPriceOptions option;
  String price;

  ChangeUnitPriceEvent(this.option, this.price);
}

final class SelectDepositTypeEvent extends OfficeEvent {
  DepositTypes type;

  SelectDepositTypeEvent(this.type);
}

final class ChangeDepositAmountEvent extends OfficeEvent {
  String amount;

  ChangeDepositAmountEvent(this.amount);
}

final class SetViewerNameEvent extends OfficeEvent {
  String name;

  SetViewerNameEvent(this.name);
}

final class SetViewerPhoneEvent extends OfficeEvent {
  String phone;

  SetViewerPhoneEvent(this.phone);
}

final class PickOfficeVideoEvent extends OfficeEvent {}

final class DeleteOfficeVideoEvent extends OfficeEvent {}

final class PickOfficeMainImageEvent extends OfficeEvent {}

final class DeleteOfficeMainImageEvent extends OfficeEvent {}

final class PickOfficeImageEvent extends OfficeEvent {}

final class DeleteOfficeImageEvent extends OfficeEvent {
  Key key;

  DeleteOfficeImageEvent(this.key);
}

final class PickOfficeLicensingFileEvent extends OfficeEvent {}

final class PickBuildingLicensingFileEvent extends OfficeEvent {}

final class PickCivilDefenseFileEvent extends OfficeEvent {}

final class NavigateToNextStepEvent extends OfficeEvent {
  int index;

  NavigateToNextStepEvent(this.index);
}

final class NavigateToPreviousStepEvent extends OfficeEvent {
  int index;

  NavigateToPreviousStepEvent(this.index);
}

final class InitialOfficeEvent extends OfficeEvent {
  Office? office;
  SearchData? searchData;

  InitialOfficeEvent(this.office, this.searchData);
}

final class ToggleEditNameAndCategoryEvent extends OfficeEvent {}

final class ToggleEditLocationEvent extends OfficeEvent {}

final class UpdateOfficeNameAndCategoryEvent extends OfficeEvent {}

final class SelectAndGetAddressPositionEvent extends OfficeEvent {
  LatLng position;
  double zoom;

  SelectAndGetAddressPositionEvent(this.position, this.zoom);
}

final class UpdateOfficeLocationEvent extends OfficeEvent {}

final class InitialOfficeLocationEvent extends OfficeEvent {
  Office office;
  SearchData searchData;

  InitialOfficeLocationEvent(this.office, this.searchData);
}

final class DeleteOfficeEvent extends OfficeEvent {
  final int id;

  const DeleteOfficeEvent(this.id);
}
