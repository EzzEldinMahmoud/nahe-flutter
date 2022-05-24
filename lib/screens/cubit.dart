import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:project/models/AGENTDETAILS.dart';
import 'package:project/models/LOGIN_model.dart';
import 'package:project/models/Appointments.dart';
import 'package:project/models/homeModel.dart';
import 'package:project/models/nearbyservicesp.dart';
import 'package:project/models/registermodel.dart';
import 'package:project/models/serviceModel.dart';
import 'package:project/models/user_info.dart';
import 'package:project/network/remote/diohelper.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/settings.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/screens/states/settingsstates.dart';

var token = StorageUtil.getString('token');

class appcubit extends Cubit<appstate> {
  appcubit(appstate initialState) : super(initialState);
  static appcubit get(context) => BlocProvider.of(context);
  late userinfo usermodel;
  late Loginmodel userget;
  HOMEMODEL? homemodel;
  NEARBYSERVICEPROVIDERS? NEARBYSERVICEPROVIDERMODEL;
  GETAGENTDETAILS? AGENTDETAILSMODEL;

  Servicemodel? servicemodel;
  APPOINTMENTMODEL? appointmentmodel;
  Future getuserdata() async {
    emit(apploadingstate());
    diohelper
        .getData(Url: get_user_info, query: {}, Token: token)
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      usermodel = userinfo.fromJson(jsonDecode(value?.data));
      if (usermodel != null) {
        print(usermodel.data.user.phoneNumber.toString());
        emit(appsuccessstate(usermodel));
      }
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error));
    });
  }

  Future gethome() async {
    emit(apphomestateloading());
    diohelper.getData(Url: GETHOME, query: {}, Token: token).then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      homemodel = HOMEMODEL.fromJson(jsonDecode(value?.data));

      if (homemodel != null) {
        print(homemodel!.data.user.name);
        emit(apphomestatesuccess(homemodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(apphomestateERROR(jsonDecode(error.toString())));
    });
    return homemodel;
  }

  Future getappointments() async {
    emit(appappointmentstateloading());
    diohelper
        .getData(Url: GETAPPOINTMENTS, query: {}, Token: token)
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      appointmentmodel = APPOINTMENTMODEL.fromJson(jsonDecode(value?.data));
      var appointmentmodel1 = appointmentmodel?.data;
      if (appointmentmodel1 != null) {
        print(appointmentmodel!.data.archivedAppointments.length);
        emit(appappointmentstatesuccess(appointmentmodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appappointmentstateError(jsonDecode(error.toString())));
    });
    return appointmentmodel;
  }

  Future GETNEARBYSERVICEPROVIDER() async {
    emit(APPSERVICENEARBYPROVIDERSLOADINGSTATE());
    diohelper
        .getData(Url: GETNEARBYSERVICEPROVIDERS, query: {}, Token: token)
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      NEARBYSERVICEPROVIDERMODEL =
          NEARBYSERVICEPROVIDERS.fromJson(jsonDecode(value?.data));

      if (NEARBYSERVICEPROVIDERMODEL != null) {
        print(NEARBYSERVICEPROVIDERMODEL!.data.nearbyProviders.length);
        emit(
            APPSERVICENEARBYPROVIDERSSUCCESSSTATE(NEARBYSERVICEPROVIDERMODEL!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(APPSERVICENEARBYPROVIDERSerrorSTATE(jsonDecode(error.toString())));
    });
    return NEARBYSERVICEPROVIDERMODEL;
  }

  Future GETAGENTDATADETAILS() async {
    emit(appservicedetailloadingstate());
    diohelper
        .getData(Url: getservicedetails, query: {}, Token: token)
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      AGENTDETAILSMODEL = GETAGENTDETAILS.fromJson(jsonDecode(value?.data));

      if (AGENTDETAILSMODEL != null) {
        print(AGENTDETAILSMODEL!.data.reviews.length);
        emit(appservicedetailsuccessstate(AGENTDETAILSMODEL!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appservicedetailERRORstate(jsonDecode(error.toString())));
    });
    return AGENTDETAILSMODEL;
  }

  Future getservice() async {
    emit(appserviceloadingstate());
    diohelper.getData(Url: GETSERVICE, query: {}, Token: token).then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${token}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      servicemodel = Servicemodel.fromJson(jsonDecode(value?.data));

      if (servicemodel != null) {
        print(servicemodel!.data.nearbyAgents.length);
        emit(appservicestatesuccess(servicemodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appservicestateERROR(jsonDecode(error.toString())));
    });
    return servicemodel;
  }

//here ends get req
  Future<void> userinfoupdate(
      {required String phone_number,
      required String name,
      required String city,
      required String district,
      required String street,
      required Token}) async {
    emit(apploadingstate());
    diohelper.postData(Url: post_user_info, data: {
      'phone_number': phone_number,
      'name': name,
      'city': city,
      'district': district,
      'street': street,
    }).then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${Token}',
      }];
      final userdata = userinfo.fromJson(jsonDecode(value?.data));

      final apimodeluse1 = userdata.data.user.name;

      if (apimodeluse1 != null) {
        print(apimodeluse1);
      } else {
        print("failed to update");
      }
      emit(appsuccessstate(userdata));
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error.toString()));
    });
  }

  Future<void> userregister(
      {required String phone_number,
      required String password,
      required String name,
      required String city,
      required String district,
      required String street,
      context}) async {
    emit(appregisterloadingstate());
    diohelper.postData(Url: REGISTER, data: {
      'phone_number': phone_number,
      'password': password,
      'name': name,
      'city': city,
      'district': district,
      'street': street,
    }).then((value) {
      final userdata = Registermodel.fromJson(jsonDecode(value?.data));

      final apimodeluse = userdata.data.token.authToken;
      StorageUtil.putString('token', apimodeluse);
      var token = StorageUtil.putString('token', apimodeluse);

      if (apimodeluse != null) {
        print(apimodeluse);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return homeScreen();
        }));
      } else {
        print("failed to register");
      }
      emit(appsuccessstateregister(userdata));
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error.toString()));
    });
  }
}

class applogincubit extends Cubit<apploginstate> {
  applogincubit(AppLoginInitialState initialState) : super(initialState);

  static applogincubit get(Context) => BlocProvider.of(Context);

  Future<void> userlogin(
      {required String phone_number, required String password, context}) async {
    emit(AppLoginLoadingState());
    diohelper.postData(Url: LOGIN, data: {
      'phone_number': phone_number,
      'password': password,
    }).then((value) {
      print(value?.data);
      final userdata = Loginmodel.fromJson(jsonDecode(value?.data));
      final apimodeluse = userdata.data.token.authToken;
      var token = StorageUtil.putString('token', apimodeluse);

      if (apimodeluse != null) {
        appcubit.get(context).getuserdata();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return homeScreen();
        }));
        print(apimodeluse.toString());
      } else {
        print("failed to login");
      }
      emit(AppLoginSuccessState(
          userdata, StorageUtil.putString('token', apimodeluse)));
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginFailedState(error.toString()));
    });
  }
}
