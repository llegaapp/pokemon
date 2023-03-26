import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../config/constant.dart';
import '../config/string_app.dart';

class LoadingInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(Constant.LOGO_ALONE)
          ),    
          SizedBox(height: 35,),
          Align(
            alignment: Alignment.center,
            child: Text(textLoadingInfo,
              style: themeApp.textSubheader,
            )
          ),          
        ],
      ),
    );
  }
}