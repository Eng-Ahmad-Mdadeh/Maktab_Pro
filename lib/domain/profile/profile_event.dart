part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}
class GetUserTypes extends ProfileEvent {}
class LogOutEvent extends ProfileEvent {}

class DeleteProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String id;
  final String userName;
  final String? companyName;
  final String? officeName;
  final String email;
  final String city;
  final String neighborhood;
  final String? idNumber;
  final String? commercialRecord;
  final String phone;
  final String? about;
  final int typeId;
  final String? image;
  final String? licenseNumber;
  final String? licenseLink;


  const UpdateProfileEvent(
      this.id,
      this.userName,
      this.companyName,
      this.officeName,
      this.email,
      this.city,
      this.neighborhood,
      this.idNumber,
      this.commercialRecord,
      this.phone,
      this.about,
      this.typeId,
      this.image,
      this.licenseNumber,
      this.licenseLink);
}

class PickImageEvent extends ProfileEvent {
  final String imagePath;

  const PickImageEvent({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class SelectAccountTypeEvent extends ProfileEvent {
  final int index;

  const SelectAccountTypeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
