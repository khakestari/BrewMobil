import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CostumerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CostumerResponse(this.id, this.name, this.numOfNotifications);

  // from json
  factory CostumerResponse.fromJson(Map<String, dynamic> json) =>
      _$CostumerResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CostumerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "email")
  String? emial;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.emial, this.phone, this.link);

  // from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "costumer")
  CostumerResponse? costumer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.costumer, this.contacts);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
