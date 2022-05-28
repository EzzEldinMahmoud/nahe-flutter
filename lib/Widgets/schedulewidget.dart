import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../network/remote/local/cachehelper.dart';
import '../screens/constants.dart';
import '../screens/cubit.dart';
import '../screens/states/loginstates.dart';

class scheduleAppointment extends StatefulWidget {
  scheduleAppointment({
    Key? key,
  }) : super(key: key);

  @override
  State<scheduleAppointment> createState() => _scheduleAppointmentState();
}

class _scheduleAppointmentState extends State<scheduleAppointment> {
  List? agentmodel;

  String? providerdetails;

  String? providerdetailsname;

  String? providerdetailsphoto;

  String? providerdetailsrating;

  String? providerdetailsaddress;

  String? providerdetailsphonenumber;
  int? providerdetailsID;

  List? values;

  List? values2;

  String Baseurl = 'http://nahe.dhulfiqar.com';

  int id = int.parse(StorageUtil.getString('id'));
  var Date = TextEditingController();
  var Time = TextEditingController();
  var Paymentmethod = TextEditingController();
  var Details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => appcubit(appservicedetailsinitialstate())
          ..GETAGENTDATADETAILS(ID: id),
        child: BlocConsumer<appcubit, appstate>(listener: (Context, State) {
          if (State is appservicedetailsuccessstate) {
            agentmodel = State.userdata.data.reviews;
            providerdetailsname = State.userdata.data.provider.name;
            providerdetailsphoto = State.userdata.data.provider.photo;
            providerdetailsrating = State.userdata.data.provider.rating;
            providerdetailsaddress = State.userdata.data.provider.address;
            providerdetailsphonenumber =
                State.userdata.data.provider.phoneNumber;
            providerdetails = State.userdata.data.provider.occupation.title;
            providerdetailsID = State.userdata.data.provider.id;
            values = providerdetailsaddress!.split(",");
            values!.forEach(print);
            values2 = values![2]!.split("G");
            values!.forEach(print);
          }
        }, builder: (Context, State) {
          return SingleChildScrollView(
              child: ConditionalBuilder(
            fallback: (context) => Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
            builder: (Context) {
              return Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 10,
                              blurStyle: BlurStyle.outer,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Scheduling",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Agent",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(Baseurl +
                                                  providerdetailsphoto!),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              providerdetails!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              providerdetailsname!,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: ratingstars(
                                                double.parse(
                                                    providerdetailsrating!),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  values![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  values![1],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                                Text(','),
                                                Text(
                                                  values2![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: Form(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Details',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Date',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {},
                                      child: TextFormField(
                                        controller: Date,
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2022, 3, 5),
                                              maxTime: DateTime(2023, 12, 28),
                                              onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            var datenow =
                                                date.toString().split(" ");
                                            datenow.forEach(print);
                                            print('confirm $date');
                                            setState(() {
                                              Date.text = datenow[0].toString();
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Enter Date.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Time',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {},
                                      child: TextFormField(
                                        onTap: () {
                                          DatePicker.showTimePicker(context,
                                              showTitleActions: true,
                                              onChanged: (date) {
                                            print('change $date in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                          }, onConfirm: (date) {
                                            var timenow =
                                                date.toString().split(" ");
                                            timenow.forEach(print);
                                            var timewithoutmini = timenow[1]
                                                .toString()
                                                .split(".");
                                            timewithoutmini.forEach(print);
                                            print('confirm $date');
                                            setState(() {
                                              Time.text =
                                                  timewithoutmini[0].toString();
                                            });
                                          }, currentTime: DateTime.now());
                                        },
                                        controller: Time,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Enter Time.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Payment Method',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {
                                        Paymentmethod.text = 'Cash';
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        onTap: () {
                                          Paymentmethod.text = 'Cash';
                                        },
                                        controller: Paymentmethod,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.expand_more,
                                            color: Colors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Choose Payment.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Details',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    TextFormField(
                                      controller: Details,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        hintText: 'Enter details.',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor:
                                            Color.fromRGBO(238, 248, 245, 0.5),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              ConditionalBuilder(
                                condition: State is! appscheduleloadingstate,
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.green),
                                ),
                                builder: (Context) {
                                  return Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 20),
                                              child: FlatButton(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                onPressed: () {
                                                  appcubit
                                                      .get(context)
                                                      .scheduleappointment(
                                                          agent_id:
                                                              providerdetailsID!,
                                                          date: Date.text,
                                                          time: Time.text,
                                                          payment_method:
                                                              Paymentmethod
                                                                  .text,
                                                          details: Details.text,
                                                          Token: StorageUtil
                                                              .getString(
                                                                  'token'));
                                                },
                                                color: Color.fromRGBO(
                                                    0, 168, 165, 0.85),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Schedule",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            child: Text(''),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 20),
                                              child: FlatButton(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                color: Color.fromARGB(
                                                    190, 170, 25, 25),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        color: Color.fromARGB(
                                                            137, 170, 25, 25))),
                                                child: Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ));
                                },
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ]))
                  ],
                ),
              );
            },
            condition: State is! appservicedetailloadingstate,
          ));
        }));
  }
}
