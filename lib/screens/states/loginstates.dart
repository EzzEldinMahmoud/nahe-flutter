import 'package:project/models/AGENTDETAILS.dart';
import 'package:project/models/LOGIN_model.dart';
import 'package:project/models/Appointments.dart';
import 'package:project/models/homeModel.dart';
import 'package:project/models/nearbyservicesp.dart';
import 'package:project/models/registermodel.dart';
import 'package:project/models/serviceModel.dart';
import 'package:project/models/user_info.dart';

abstract class appstate {}

class appinitialstate extends appstate {}

class apploadingstate extends appstate {}

class appsuccessstate extends appstate {
  final userinfo userdata;

  appsuccessstate(
    this.userdata,
  );
}

class appERRORstate extends appstate {
  final String error;
  appERRORstate(this.error);
}

class appservicedetailsinitialstate extends appstate {}

class appservicedetailloadingstate extends appstate {}

class appservicedetailsuccessstate extends appstate {
  final GETAGENTDETAILS userdata;

  appservicedetailsuccessstate(
    this.userdata,
  );
}

class appservicedetailERRORstate extends appstate {
  final String error;
  appservicedetailERRORstate(this.error);
}

class APPSERVICENEARBYPROVIDERSINITIALSTATE extends appstate {}

class APPSERVICENEARBYPROVIDERSLOADINGSTATE extends appstate {}

class APPSERVICENEARBYPROVIDERSSUCCESSSTATE extends appstate {
  final NEARBYSERVICEPROVIDERS userdata;

  APPSERVICENEARBYPROVIDERSSUCCESSSTATE(
    this.userdata,
  );
}

class APPSERVICENEARBYPROVIDERSerrorSTATE extends appstate {
  final String error;
  APPSERVICENEARBYPROVIDERSerrorSTATE(this.error);
}

class appregisterstate extends appstate {}

class appregisterloadingstate extends appstate {}

class appsuccessstateregister extends appstate {
  final Registermodel userdata;

  appsuccessstateregister(
    this.userdata,
  );
}

class appERRORstateregister extends appstate {
  final String error;
  appERRORstateregister(this.error);
}

class appappointmentstateinitial extends appstate {}

class appappointmentstateloading extends appstate {}

class appappointmentstatesuccess extends appstate {
  final APPOINTMENTMODEL appointmentmodel;

  appappointmentstatesuccess(
    this.appointmentmodel,
  );
}

class appappointmentstateError extends appstate {
  final String error;
  appappointmentstateError(this.error);
}

class appserviceinitialstate extends appstate {}

class appserviceloadingstate extends appstate {}

class appservicestatesuccess extends appstate {
  final Servicemodel servicemodel;

  appservicestatesuccess(
    this.servicemodel,
  );
}

class appservicestateERROR extends appstate {
  final String error;
  appservicestateERROR(this.error);
}

class apphomestateinitial extends appstate {}

class apphomestateloading extends appstate {}

class apphomestatesuccess extends appstate {
  final HOMEMODEL homemodel;

  apphomestatesuccess(
    this.homemodel,
  );
}

class apphomestateERROR extends appstate {
  final error;
  apphomestateERROR(this.error);
}

class appuserintialstate extends appstate {}

class appuserloadingstate extends appstate {}

class appusersuccessstate extends appstate {
  late final Loginmodel userdata;
  late final Loginmodel token;
  appusersuccessstate(this.userdata, this.token);
}

class appuserERRORstate extends appstate {}

class AppsettingInitialState extends appstate {}

class AppsettingSuccessState extends appstate {
  late final userinfo loginmodel;
  AppsettingSuccessState(this.loginmodel);
}

class AppsettingFailedState extends appstate {
  late final error;
  AppsettingFailedState(this.error);
}

class AppsettingLoadingState extends appstate {}

abstract class apploginstate {}

class AppLoginInitialState extends apploginstate {}

class AppLoginSuccessState extends apploginstate {
  final Loginmodel userdata;
  AppLoginSuccessState(this.userdata, Future<bool> token);
}

class AppLoginFailedState extends apploginstate {
  final String error;
  AppLoginFailedState(this.error);
}

class AppLoginLoadingState extends apploginstate {}
