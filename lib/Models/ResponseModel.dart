// ignore_for_file: file_names, unnecessary_this

class ResponseModel {
  String? msg;
  bool? status;
  String? token;
  dynamic data;
  ResponseModel() {
    // return new ResponseModel();
  }
  get getmsg => this.msg;

  set setmsg(String msg) => this.msg = msg;
  get getData => this.data;

  set setData(dynamic data) => this.data = data;
  get getToken => this.token;

  set setToken(String token) => this.token = token;
  get getstatus => this.status;

  set setstatus(bool status) => this.status = status;
  ResponseModel.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
    this.status = json['status'];
    this.token = json['token'];
    this.data = json['data'];
  }
  @override
  String toString() {
    
    return "${this.msg} / ${this.status} / ${this.token} / ${this.data.toString()}";
  }
}
