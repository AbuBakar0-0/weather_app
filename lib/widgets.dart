import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';

gap10(){
  return const SizedBox(height: 10,);
}

gap15(){
  return const SizedBox(height: 15,);
}

gap20(){
  return const SizedBox(height: 20,);
}

weather(snap){
  DateFormat formatter = DateFormat('dd-MMM'); // Example format
  DateTime parsedDate = DateTime.parse(snap['date'].toString());
  var icon=Icons.sunny;
  var color=Colors.yellowAccent;

  if(true){

  }

  return Container(
    padding:EdgeInsets.symmetric(vertical: 25,horizontal: 20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            formatter.format(parsedDate).toString(),
          ),
          Image(image: NetworkImage("http:"+snap['day']['condition']['icon'])),
          // GlowIcon(Icons.wb_sunny_outlined,color: Colors.yellowAccent,),
          Text(
            "${snap['day']['mintemp_c'].toString().split('.')[0]}°/${snap['day']['maxtemp_c'].toString().split('.')[0]}°",
          ),
          Text(
              snap['day']['condition']['text'],
          ),
        ],
      ),
    ),
  );
}