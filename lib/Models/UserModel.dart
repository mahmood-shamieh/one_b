// ignore_for_file: file_names, unnecessary_this, curly_braces_in_flow_control_structures

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? adress;
  DateTime? createDate;
  String? balance;
  String? actvie;
  String? verified;
  DateTime? verficationCodeDate;
  String? level;
  String? userName;
  String? email;
  String? mobile;
  String? password;
  String? gender;
  String? token;
  // ignore: non_constant_identifier_names
  String? FCM_token;
  String? canCharge;

  set setToken(String token) => this.token = token;

  get getToken => this.token;
  
  // ignore: non_constant_identifier_names
  set setFCMToken(String FCM_token) => this.FCM_token = FCM_token;

  get getFCMToken => this.FCM_token;

  set setVerficationCodeDate(verficationCodeDate) =>
      this.verficationCodeDate = verficationCodeDate;
  get getId => this.id;

  set setId(String id) => this.id = id;

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;

  get getAdress => this.adress;

  set setAdress(adress) => this.adress = adress;

  get getCreateDate => this.createDate;

  set setCreateDate(createDate) => this.createDate = createDate;

  get getBalance => this.balance;

  set setBalance(balance) => this.balance = balance;

  get getActvie => this.actvie;

  set setActvie(actvie) => this.actvie = actvie;

  get getVerified => this.verified;

  set setVerified(verified) => this.verified = verified;

  get getVerficationCodeDate => this.verficationCodeDate;

  String? get getLevel => this.level;

  set setLevel(String level) => this.level = level;

  get getUserName => this.userName;

  set setUserName(userName) => this.userName = userName;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getMobile => this.mobile;

  set setMobile(mobile) => this.mobile = mobile;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getGender => this.gender;

  set setGender(gender) => this.gender = gender;
  UserModel.fromJson(Map json) {
    
    if (json == null) return;
    this.email = json['email'];
    this.level = json['user_level'].toString();
    this.mobile = json['phone'];
    this.password = json['password'];
    this.actvie = json['active'].toString();
    this.userName = json['username'];
    this.adress = json['address'];
    if (json['balance'] != null) this.balance = json['balance'];
    if (json['create_date'] != null)
      this.createDate = DateTime.parse(json['create_date']);
    this.id = json['id'].toString();
    this.lastName = json['last_name'];
    this.firstName = json['first_name'];
    this.verified = json['verified'].toString();
    this.token = json['token'].toString();
    this.FCM_token = json['FCM_token'].toString() ?? "" ;
    this.canCharge = json['can_charge'].toString() ?? "" ;
  }
  Map<dynamic, dynamic> toJson() {
    Map json = {
      "id": this.id,
      "username": this.userName,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "email": this.email,
      "phone": this.mobile,
      "user_level": this.level,
      "address": this.adress,
      "create_date": this.createDate.toString(),
      "balance": this.balance.toString(),
      "active": this.actvie,
      "ver_code": null,
      "verified": this.verified,
      "ver_code_date": null,
      "token": this.token,
      "FCM_token": this.FCM_token,
      "can_charge" : this.canCharge
    };
    return json;
  }

  // UserModel() {
  //   this.id = "1";
  //   this.actvie = "1";
  //   this.firstName = "aa";
  //   this.lastName = "bbbb";
  //   this.email = "etset@gmail.com";
  //   this.userName = "mndalskjd";
  // }
  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.level,
    this.mobile,
    this.password,
    this.userName,
    this.adress,
  });
}
