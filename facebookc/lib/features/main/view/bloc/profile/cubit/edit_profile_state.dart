part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  final String message;

  const EditProfileFailure(this.message);
}