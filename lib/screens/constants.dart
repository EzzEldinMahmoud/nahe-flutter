

import 'package:flutter/material.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/start_screen.dart';
import '../network/remote/local/cachehelper.dart';
import './settings.dart';
void signout(context ){
  StorageUtil.clrString(
    'token'
  ).then((value) {
    
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  first_form()));
    
  });
}
class addressspiltreturns{
    final String city;
    final String district;
    final String street;


    addressspiltreturns( this.street,this.city, this.district);
}