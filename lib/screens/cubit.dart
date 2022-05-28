import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Widgets/schedulewidget.dart';
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

import '../models/SEARCHAGENTMODEL.dart';
import '../models/appointschedule.dart';

class appcubit extends Cubit<appstate> {
  appcubit(appstate initialState) : super(initialState);
  static appcubit get(context) => BlocProvider.of(context);
  userinfo? usermodel;
  Loginmodel? userget;
  HOMEMODEL? homemodel;
  NEARBYSERVICEPROVIDERS? NEARBYSERVICEPROVIDERMODEL;
  AgentdetailModel? AGENTDETAILSMODEL;

  Servicemodel? servicemodel;
  APPOINTMENTMODEL? appointmentmodel;
  Future getuserdata() async {
    emit(apploadingstate());
    diohelper
        .getData(
            Url: get_user_info,
            query: {},
            Token: StorageUtil.getString('token'))
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
      }];

      usermodel = userinfo.fromJson(jsonDecode(value?.data));
      if (usermodel != null) {
        print(usermodel!.data.user.phoneNumber.toString());
        emit(appsuccessstate(usermodel!));
      }
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error));
    });
    return usermodel;
  }

  Future gethome() async {
    emit(apphomestateloading());
    diohelper
        .getData(Url: GETHOME, query: {}, Token: StorageUtil.getString('token'))
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
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
        .getData(
            Url: GETAPPOINTMENTS,
            query: {},
            Token: StorageUtil.getString('token'))
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
        .getData(
            Url: GETNEARBYSERVICEPROVIDERS,
            query: {},
            Token: StorageUtil.getString('token'))
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

  Future GETAGENTDATADETAILS({required int ID}) async {
    emit(appservicedetailloadingstate());
    diohelper
        .postData(
            Url: getservicedetails,
            query: {},
            Token: StorageUtil.getString('token'),
            data: {'agent_id': ID})
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      AGENTDETAILSMODEL = AgentdetailModel.fromJson(jsonDecode(value?.data));

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

  Future getsearchresult({required String jobtitle}) async {
    emit(appsearchloadingstate());
    diohelper
        .postData(
            Url: SEARCHPAGERESULT,
            query: {},
            Token: StorageUtil.getString('token'),
            data: {'query': jobtitle})
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
      }];

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      final SEARCHAGENTDETAILSMODEL =
          SEARCHAGENTSNEARBY.fromJson(jsonDecode(value?.data));

      if (SEARCHAGENTDETAILSMODEL != null) {
        print(SEARCHAGENTDETAILSMODEL.data);
        emit(appsearchsuccessstate(SEARCHAGENTDETAILSMODEL));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appsearchERRORstate(jsonDecode(error.toString())));
    });
  }

  Future getservice() async {
    emit(appserviceloadingstate());
    diohelper
        .getData(
            Url: GETSERVICE, query: {}, Token: StorageUtil.getString('token'))
        .then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
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
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
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

  Future<void> scheduleappointment(
      {required int agent_id,
      required String date,
      required String time,
      required String payment_method,
      required String details,
      required Token}) async {
    emit(appscheduleloadingstate());
    diohelper.postData(Url: SCHEDULEAPPOINTMENT, data: {
      'agent_id': agent_id,
      'date': date,
      'time': time,
      'payment_method': payment_method,
      'details': details,
    }).then((value) {
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${StorageUtil.getString('token')}',
      }];
      final scheduleAppointmentmodel =
          ScheduleAPPOINTMENTMODEL.fromJson(jsonDecode(value?.data));

      final apimodeluse1 = scheduleAppointmentmodel.data.appointment;

      if (apimodeluse1 != null) {
        print(apimodeluse1.date);
      } else {
        print("failed to update");
      }
      emit(appschedulesuccessstate(scheduleAppointmentmodel));
    }).catchError((error) {
      print(error.toString());
      emit(appscheduleERRORstate(error.toString()));
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

      if (apimodeluse != null) {
        StorageUtil.clrString('token');
        StorageUtil.putString('token', apimodeluse);
        print(apimodeluse);
        var token = StorageUtil.putString('token', apimodeluse);
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

      if (apimodeluse != null) {
        StorageUtil.clrString('token');
        StorageUtil.putString('token', apimodeluse);

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
