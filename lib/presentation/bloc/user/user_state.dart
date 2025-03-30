part of 'user_cubit.dart';



abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserEditing extends UserState {}
class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}
class UserEdited extends UserState {
  final User user;
  UserEdited(this.user);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}
class UserPurchasing extends UserState {}
class UserPurchased extends UserState {
  final User user;
  UserPurchased(this.user);
}
class UserPurchasedError extends UserState {}
// abstract class UserState extends Equatable {
//   const UserState({this.appUser});
//   final AppUser? appUser;
//   @override
//   List<Object?> get props => [appUser];
// }
//
// class UserNotLoaded extends UserState {
//   const UserNotLoaded() : super(appUser: null);
// }
//
// class UserLoaded extends UserState {
//   const UserLoaded(this.appUser) : super(appUser: appUser);
//
//   final AppUser appUser;
//
//   @override
//   List<Object> get props => [appUser];
//
//   @override
//   String toString() => 'UserLoaded { AppUser: $appUser  }';
// }
//
// class UserPreLoaded extends UserLoaded {
//   const UserPreLoaded(this.appUser) : super(appUser);
//
//   final AppUser appUser;
//
//   @override
//   List<Object> get props => [appUser];
//
//   @override
//   String toString() => 'UserLoaded { AppUser: $appUser  }';
// }
//
// class UserEditInProgress extends UserLoaded {
//   const UserEditInProgress(AppUser appUser) : super(appUser);
// }
//
// class UserEditSuccess extends UserLoaded {
//   const UserEditSuccess(AppUser appUser) : super(appUser);
// }
//
// class UserSaveLanguageInProgress extends UserLoaded {
//   const UserSaveLanguageInProgress(AppUser appUser) : super(appUser);
// }
//
// class UserSaveLanguageSuccess extends UserLoaded {
//   const UserSaveLanguageSuccess(AppUser appUser) : super(appUser);
// }
//
// class GetSubscriptionsSuccess extends UserLoaded {
//   const GetSubscriptionsSuccess(this.user) : super(user);
//   final AppUser user;
// }
