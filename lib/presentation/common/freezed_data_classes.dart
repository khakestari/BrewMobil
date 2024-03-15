import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject implements _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;

  @override
  // TODO: implement copyWith
  $LoginObjectCopyWith<LoginObject> get copyWith => throw UnimplementedError();

  @override
  // TODO: implement password
  String get password => throw UnimplementedError();

  @override
  // TODO: implement userName
  String get userName => throw UnimplementedError();
}
