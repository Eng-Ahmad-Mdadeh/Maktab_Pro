
part of 'unit_bloc.dart';

enum VisibilityStates { show, hide }

enum ToggleStates { on, off }

enum AdertiserRelationshipOptions { none, owner, agent, marketer }

enum MarketerTypes { none, exclusive, notExclusive }

enum UnitPriceOptions { hourly, daily, monthly, yearly }

enum DepositTypes { price, percentage }

enum StepNavigationState { initial, next, previous, end }

enum UnitApiCallState { initial, noCall, loading, success, failure }

sealed class UnitEvent extends Equatable {
  const UnitEvent();

  @override
  List<Object> get props => [];
}

final class SetUnitNameEvent extends UnitEvent {
  final String name;

  const SetUnitNameEvent(this.name);
}

final class SelectCategoryEvent extends UnitEvent {
  final int id;

  const SelectCategoryEvent(this.id);
}

final class SelectAdertiserRelationshipEvent extends UnitEvent {
  final AdertiserRelationshipOptions option;

  const SelectAdertiserRelationshipEvent(this.option);
}

final class SelectMarketerTypeEvent extends UnitEvent {
  final MarketerTypes option;

  const SelectMarketerTypeEvent(this.option);
}

final class SetSpaceEvent extends UnitEvent {
  final String space;

  const SetSpaceEvent(this.space);
}

final class SetEquipmentEvent extends UnitEvent {
  final String equipment;

  const SetEquipmentEvent(this.equipment);
}

final class SetTypeEvent extends UnitEvent {
  final String type;

  const SetTypeEvent(this.type);
}

final class IncreaseFloorEvent extends UnitEvent {
  int floor;

  IncreaseFloorEvent(this.floor);
}

final class DecreaseFloorEvent extends UnitEvent {
  int floor;

  DecreaseFloorEvent(this.floor);
}

final class IncreaseOfficeAgeEvent extends UnitEvent {
  int age;

  IncreaseOfficeAgeEvent(this.age);
}

final class DecreaseOfficeAgeEvent extends UnitEvent {
  int age;

  DecreaseOfficeAgeEvent(this.age);
}

final class ToggleOfficesCountSelectorEvent extends UnitEvent {}

final class IncreaseOfficesCountEvent extends UnitEvent {
  int count;

  IncreaseOfficesCountEvent(this.count);
}

final class DecreaseOfficesCountEvent extends UnitEvent {
  int count;

  DecreaseOfficesCountEvent(this.count);
}

final class ToggleMeetingRoomsCountSelectorEvent extends UnitEvent {}

final class IncreaseMeetingRoomsCountEvent extends UnitEvent {
  int count;

  IncreaseMeetingRoomsCountEvent(this.count);
}

final class DecreaseMeetingRoomsCountEvent extends UnitEvent {
  int count;

  DecreaseMeetingRoomsCountEvent(this.count);
}

final class ToggleTablesCountSelectorEvent extends UnitEvent {}

final class IncreaseTablesCountEvent extends UnitEvent {
  int count;

  IncreaseTablesCountEvent(this.count);
}

final class DecreaseTablesCountEvent extends UnitEvent {
  int count;

  DecreaseTablesCountEvent(this.count);
}

final class ToggleSharedWorkSpacesSelectorEvent extends UnitEvent {}

final class IncreaseSharedWorkSpacesCountEvent extends UnitEvent {
  int count;

  IncreaseSharedWorkSpacesCountEvent(this.count);
}

final class DecreaseSharedWorkSpacesCountEvent extends UnitEvent {
  int count;

  DecreaseSharedWorkSpacesCountEvent(this.count);
}

final class SelectFacilityEvent extends UnitEvent {
  final int id;

  const SelectFacilityEvent(this.id);
}

final class SetDescriptionEvent extends UnitEvent {
  final String description;

  const SetDescriptionEvent(this.description);
}

final class SelectFeatureEvent extends UnitEvent {
  final int id;

  const SelectFeatureEvent(this.id);
}

final class SelectServiceEvent extends UnitEvent {
  final int id;

  const SelectServiceEvent(this.id);
}

final class SelectComfortEvent extends UnitEvent {
  final int id;

  const SelectComfortEvent(this.id);
}

final class AddAddtionalServiceEvent extends UnitEvent {}

final class RemoveAdditionalServiceEvent extends UnitEvent {
  final Key key;

  const RemoveAdditionalServiceEvent(this.key);
}

final class SetInterfaceEvent extends UnitEvent {
  final String interface;

  const SetInterfaceEvent(this.interface);
}

final class ToggleUnitPriceOptionEvent extends UnitEvent {
  final UnitPriceOptions option;

  const ToggleUnitPriceOptionEvent(this.option);
}

final class ChangeUnitPriceEvent extends UnitEvent {
  final UnitPriceOptions option;
  final String price;

  const ChangeUnitPriceEvent(this.option, this.price);
}

final class SelectDepositTypeEvent extends UnitEvent {
  final DepositTypes type;

  const SelectDepositTypeEvent(this.type);
}

final class ChangeDepositAmountEvent extends UnitEvent {
  final String amount;

  const ChangeDepositAmountEvent(this.amount);
}

final class SetViewerNameEvent extends UnitEvent {
  final String name;

  const SetViewerNameEvent(this.name);
}

final class SetViewerPhoneEvent extends UnitEvent {
  final String phone;

  const SetViewerPhoneEvent(this.phone);
}

final class PickOfficeVideoEvent extends UnitEvent {}

final class DeleteOfficeVideoEvent extends UnitEvent {}

final class PickOfficeMainImageEvent extends UnitEvent {}

final class DeleteOfficeMainImageEvent extends UnitEvent {}

final class PickOfficeImageEvent extends UnitEvent {}

final class DeleteOfficeImageEvent extends UnitEvent {
  final Key key;

  const DeleteOfficeImageEvent(this.key);
}

final class NavigateToNextStepEvent extends UnitEvent {
  final int index;

  const NavigateToNextStepEvent(this.index);
}

final class NavigateToPreviousStepEvent extends UnitEvent {
  final int index;

  const NavigateToPreviousStepEvent(this.index);
}

final class InitialUnitEvent extends UnitEvent {
  final Office? unit;
  final Office? office;
  final SearchData? searchData;

  const InitialUnitEvent(this.unit, this.office, this.searchData);
}

final class UpdateUnitInfoEvent extends UnitEvent {}

final class UpdateUnitStatusEvent extends UnitEvent {
  int unitId;

  UpdateUnitStatusEvent(this.unitId);
}

final class UpdateUnitCategoryEvent extends UnitEvent {}

final class UpdateUnitDetailsEvent extends UnitEvent {}

final class UpdateUnitDescriptionEvent extends UnitEvent {}

final class UpdateUnitFacilitiesEvent extends UnitEvent {}

final class UpdateUnitFeaturesEvent extends UnitEvent {}

final class UpdateUnitComfortsEvent extends UnitEvent {}

final class UpdateUnitPricesEvent extends UnitEvent {}

final class UpdateUnitDepositEvent extends UnitEvent {}

final class UpdateUnitFilesEvent extends UnitEvent {}

final class DeleteUnitEvent extends UnitEvent {
  final int id;

  const DeleteUnitEvent(this.id);
}
