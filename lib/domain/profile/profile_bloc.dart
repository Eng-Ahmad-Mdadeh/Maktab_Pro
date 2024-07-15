// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/core/helpers/file_picker_helper.dart';
import 'package:maktab_lessor/core/helpers/image_cropper_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/user/user_model.dart';
import 'package:maktab_lessor/data/models/user/user_type.dart';
import 'package:maktab_lessor/data/repositories/auth_repository.dart';
import 'package:maktab_lessor/data/repositories/profile_repository.dart';
import 'package:maktab_lessor/data/repositories/user_repository.dart';

import '../../core/services/notification_services.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final UserRepository _userTypesRepository;
  final AuthRepository _authRepository;

  ProfileBloc(
      {required ProfileRepository profileRepository,
      required AuthRepository authRepository,
      required UserRepository userRepository})
      : _profileRepository = profileRepository,
        _userTypesRepository = userRepository,
        _authRepository = authRepository,
        super(const ProfileState(
            profileState: ProfileStates.initial,
            user: null,
            userTypes: null,
            message: '',
            pickedImage: '',
            selectedAccountTypeIndex: 1,
            isCompleted: null,
            fetchingUserTypes: FetchUserTypes.initial,
            logOutStates: LogOutStates.initial,
            imageErrorMessage: '')) {
    on<GetProfileEvent>((event, emit) async {
      emit(state.copyWith(profileState: ProfileStates.loading));
      // log(state.toString());
      try {
        var result = await _profileRepository.getProfile();
        result.fold(
          (failure) => emit(state.copyWith(
            profileState: ProfileStates.failure,
            message: failure.message,
          )),
          (user) async {
            if (user.type?.arName != '') {
              int ind = getUserTypeAccountInd(user);
              emit(state.copyWith(
                profileState: ProfileStates.success,
                selectedAccountTypeIndex: ind,
                user: user,
              ));
            } else {
              emit(state.copyWith(
                profileState: ProfileStates.success,
                user: user,
              ));
            }
            await NotificationService.init(user.id);
          },
        );
      } catch (e) {
        emit(state.copyWith(
          profileState: ProfileStates.failure,
          message: e.toString(),
        ));
      }
    });
    on<GetUserTypes>((event, emit) async {
      emit(state.copyWith(fetchingUserTypes: FetchUserTypes.loading));
      try {
        var result = await _userTypesRepository.getUserTypes();
        result.fold(
          (failure) => emit(state.copyWith(
            fetchingUserTypes: FetchUserTypes.failure,
            message: failure.message,
          )),
          (userTypes) {
            userTypes.removeWhere((element) => element.id == 4);
            emit(state.copyWith(
              fetchingUserTypes: FetchUserTypes.success,
              userTypes: userTypes,
            ));
          },
        );
      } catch (e) {
        emit(state.copyWith(
          fetchingUserTypes: FetchUserTypes.failure,
          message: e.toString(),
        ));
      }
    });
    on<UpdateProfileEvent>((event, emit) async {
      emit(state.copyWith(profileState: ProfileStates.loadingForEdit));
      try {
        var result = await _profileRepository.updateProfile(
            id: event.id,
            userName: event.userName,
            companyName: event.companyName,
            officeName: event.officeName,
            email: event.email,
            city: event.city,
            about: event.about,
            neighborhood: event.neighborhood,
            idNumber: event.idNumber,
            typeId: event.typeId,
            commercialRecord: event.commercialRecord,
            image: event.image,
            licenseNumber: event.licenseNumber,
            licenseLink: event.licenseLink);
        result.fold(
          (failure) {
            // log("error message:${failure.message}");
            emit(state.copyWith(
              profileState: ProfileStates.failToUpdate,
              message: failure.message,
            ));
          },
          (user) {
            // log(" success message:${user.companyName}");
            emit(state.copyWith(
                profileState: ProfileStates.updated, user: user, message: "تم تحديث الملف الشخصي بنجاح"));
          },
        );
      } catch (e) {
        log("catch message:${e.toString()}");
        emit(state.copyWith(
          profileState: ProfileStates.failToUpdate,
          message: e.toString(),
        ));
      }
    });

    on<DeleteProfileEvent>((event, emit) async {
      emit(state.copyWith(profileState: ProfileStates.loadingForEdit));
      try {
        var result = await _profileRepository.deleteAccount();
        result.fold(
          (failure) {
            // log("error message:${failure.message}");
            emit(state.copyWith(
              profileState: ProfileStates.failToUpdate,
              message: failure.message,
            ));
          },
          (user) {
            // log(" success message:${user.companyName}");
            emit(state.copyWith(
              profileState: ProfileStates.deleted,
              message: "تم ارسال طلب الحذف",
            ));
            add(GetProfileEvent());
          },
        );
      } catch (e) {
        log("catch message:${e.toString()}");
        emit(state.copyWith(
          profileState: ProfileStates.failToUpdate,
          message: e.toString(),
        ));
      }
    });

    on<PickImageEvent>((event, emit) async {
      emit(state.copyWith(imageErrorMessage: ''));
      String? selectedImage = await locator<FilePickerHelper>().pickImage();
      if (selectedImage != null && selectedImage.isNotEmpty) {
        String? croppedImage = await ImageCropperHelper.cropImage(selectedImage: selectedImage);
        if (croppedImage != null) {
          emit(state.copyWith(
            pickedImage: croppedImage,
            imageErrorMessage: '',
          ));
        }
      } else {
        emit(state.copyWith(imageErrorMessage: 'يجب أن يكون حجم الصورة أصغر من 2 ميغا بايت'));
      }
    });
    on<SelectAccountTypeEvent>((event, emit) async {
      emit(state.copyWith(selectedAccountTypeIndex: event.index));
    });
    on<LogOutEvent>((event, emit) async {
      emit(state.copyWith(
        logOutStates: LogOutStates.loading,
      ));
      try {
        var result = await _authRepository.logout();
        result.fold(
          (failure) => emit(state.copyWith(
            logOutStates: LogOutStates.failure,
            message: failure.message,
          )),
          (response) {
            emit(state.copyWith(
              logOutStates: LogOutStates.success,
            ));
          },
        );
      } catch (e) {
        emit(state.copyWith(
          logOutStates: LogOutStates.failure,
          message: e.toString(),
        ));
      }
      emit(state.copyWith(
        logOutStates: LogOutStates.initial,
      ));
    });
  }

  int getUserTypeAccountInd(User user) {
    int ind = 1;
    if (user.type?.arName == 'مسوق') {
      ind = 2;
    } else if (user.type?.arName == 'مالك') {
      ind = 3;
    } else if (user.type?.arName == 'مكتب') {
      ind = 5;
    }

    return ind;
  }

  bool checkIfProfileCompleted(User user) {
    bool isCompleted = false;
    if (user.companyName == '' && user.type?.id == 1) {
      return false;
    }
    if (user.officeName == '' && user.type?.id == 5) {
      return false;
    }
    if (user.userName != '' &&
        user.email != '' &&
        user.licenseLink != '' &&
        user.licenseNumber != '' &&
        user.city != '' &&
        user.neighborhood != '' &&
        user.idNumber != '' &&
        user.type != null) {
      isCompleted = true;
    }
    return isCompleted;
  }
}
