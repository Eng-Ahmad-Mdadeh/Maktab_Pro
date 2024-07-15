part of 'profile_bloc.dart';

enum ProfileStates {
  initial,
  loading,
  loadingForEdit,
  success,
  deleted,
  failure,
  updated,
  failToUpdate
}

enum FetchUserTypes {
  initial,
  loading,
  success,
  failure,
}

enum LogOutStates {
  initial,
  loading,
  success,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.profileState,
    required this.user,
    required this.userTypes,
    required this.message,
    required this.pickedImage,
    required this.selectedAccountTypeIndex,
    required this.fetchingUserTypes,
    required this.logOutStates,
    required this.imageErrorMessage,
    this.isCompleted,
  });

  final ProfileStates profileState;
  final User? user;
  final List<UserType>? userTypes;
  final String message;
  final String pickedImage;
  final int selectedAccountTypeIndex;
  final bool? isCompleted;
  final FetchUserTypes fetchingUserTypes;
  final LogOutStates logOutStates;
  final String imageErrorMessage;

  @override
  List<Object> get props => [
        profileState,
        message,
        pickedImage,
        selectedAccountTypeIndex,
        fetchingUserTypes,
        logOutStates,
        imageErrorMessage,
      ];

  ProfileState copyWith(
      {ProfileStates? profileState,
      User? user,
      List<UserType>? userTypes,
      String? message,
      String? pickedImage,
      int? selectedAccountTypeIndex,
      bool? isCompleted,
      LogOutStates? logOutStates,
      String? imageErrorMessage,
      FetchUserTypes? fetchingUserTypes}) {
    return ProfileState(
        profileState: profileState ?? this.profileState,
        user: user ?? this.user,
        userTypes: userTypes ?? this.userTypes,
        message: message ?? this.message,
        pickedImage: pickedImage ?? this.pickedImage,
        selectedAccountTypeIndex:
            selectedAccountTypeIndex ?? this.selectedAccountTypeIndex,
        isCompleted: isCompleted ?? this.isCompleted,
        fetchingUserTypes: fetchingUserTypes ?? this.fetchingUserTypes,
        logOutStates: logOutStates ?? this.logOutStates,
        imageErrorMessage: imageErrorMessage ?? this.imageErrorMessage);
  }
}
