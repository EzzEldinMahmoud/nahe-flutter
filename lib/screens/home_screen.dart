import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/homeModel.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/searchpage.dart';
import 'package:project/screens/servicepage.dart';
import 'package:project/screens/settings.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/screens/upcoming_appointments.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    super.initState();
  }

  String Baseurl = 'http://nahe.dhulfiqar.com';
  HOMEMODEL? here;
  String? image;
  List? herelengthlsit;
  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => appcubit(appinitialstate())
        ..gethome()
        ..getuserdata(),
      child:
          BlocConsumer<appcubit, appstate>(listener: ((context, state) async {
        if (state is apphomestatesuccess) {
          here = state.homemodel;
          herelengthlsit = here!.data.upcomingAppointments;
          print(state.homemodel.data.user.name);
        }
      }), builder: (context, state) {
        return ConditionalBuilder(
          condition: here != null,
          fallback: (Context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          builder: (Context) {
            return Material(
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            ConditionalBuilder(
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                    color: Colors.green),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 40, left: 20, right: 20, bottom: 10),
                                  child: Text(
                                    "Hey, ${here?.data.user.name}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                              condition: state is! appserviceloadingstate,
                            ),
                            Expanded(
                              child: Text(""),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => settingsScreen()));
                              },
                              child: ConditionalBuilder(
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.green),
                                ),
                                builder: (context) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: 35, left: 20, right: 20),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            HslColor(187, 250, 231),
                                        backgroundImage: NetworkImage(
                                            Baseurl + here!.data.user.photo),
                                      ));
                                },
                                condition: state is! apphomestateloading,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(197, 255, 255, 255),
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75))
                          ],
                        ),
                        child: TextField(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return searchpage();
                            }));
                          },
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 22, horizontal: 20),
                            fillColor: Color.fromRGBO(238, 247, 246, 0.5),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            hintText: 'Search for electricians,plumbers,etc...',
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return serviceScreen();
                                }));
                              },
                              child: Text(
                                "Services",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(child: Text('')),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => serviceScreen()));
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 30, right: 30),
                                child: Icon(Icons.arrow_forward)),
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.42,
                        width: MediaQuery.of(context).size.width * 1,
                        child: GridView.count(
                            primary: false,
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            children: List.generate(here!.data.services.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: HexColor(
                                        here!.data.services[index].colour),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        "${Baseurl + here!.data.services[index].icon}",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Text(
                                        here!.data.services[index].title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 1, left: 0, right: 0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return serviceScreen();
                                })),
                                child: Text(
                                  "Upcoming appointments",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(child: Text('')),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 1, left: 0, right: 0),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => appointmentpage()),
                                      );
                                    },
                                    icon: Icon(Icons.arrow_forward)))
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        builder: (context) {
                          print(here!.data.upcomingAppointments[0].agent.photo);
                          return Container(
                              transform: Matrix4.translationValues(0, -20, 0),
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: herelengthlsit?.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              margin: EdgeInsets.all(4),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffEEF6F6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                padding: EdgeInsets.all(15),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              new DecorationImage(
                                                            image: new NetworkImage(
                                                                Baseurl +
                                                                    here!
                                                                        .data
                                                                        .upcomingAppointments[
                                                                            index]
                                                                        .agent
                                                                        .photo),
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                      height: 10,
                                                    ),
                                                    Container(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          here!
                                                              .data
                                                              .upcomingAppointments[
                                                                  index]
                                                              .status,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          here!
                                                              .data
                                                              .upcomingAppointments[
                                                                  index]
                                                              .agent
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          here!
                                                              .data
                                                              .upcomingAppointments[
                                                                  index]
                                                              .agent
                                                              .occupation
                                                              .title,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        Expanded(
                                                          child: Text(""),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.03,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.27,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffff00A8A3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_month_sharp,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 17,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    here!
                                                                        .data
                                                                        .upcomingAppointments[
                                                                            index]
                                                                        .date,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.03,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.24,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffff00A8A3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .access_alarm_sharp,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 17,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    here!
                                                                        .data
                                                                        .upcomingAppointments[
                                                                            index]
                                                                        .time,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              )),
                                        ));
                                  }));
                        },
                        condition: here!.data.upcomingAppointments.isNotEmpty,
                        fallback: (BuildContext context) {
                          return Center(
                            child: Text('there are currently no  appointments'),
                          );
                        },
                      )
                    ])));
          },
        );
      }),
    );
  }
}
