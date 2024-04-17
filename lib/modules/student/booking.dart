import 'package:crafton_final/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_text_style.dart';
import '../../widgets/custom_utils.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         child: Column(
           children: [

             SizedBox(height: 40,),


             Container(
               padding: const EdgeInsets.all(8.0),
               decoration: BoxDecoration(
                 border: Border.all(

                 )
               ),
               child: Column(
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment:
                 CrossAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(
                         right: 8, top: 4),
                     child: Text(
                       'name',
                       maxLines: 2,
                       softWrap: true,
                       style: CustomTextStyle
                           .textFormFieldSemiBold
                           .copyWith(fontSize: 14),
                     ),
                   ),
                   Utils.getSizedBox(height: 6),

                   Container(
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment
                           .spaceBetween,
                       children: <Widget>[
                         Text(
                           "a",
                           style: CustomTextStyle
                               .textFormFieldBlack
                               .copyWith(
                               color: Colors.green),
                         ),
                         Spacer(),
                         CustomButton(
                           text: 'Accept',
                           onPressed: () {



                         },)
                       ],
                     ),
                   ),
                 ],
               ),
             )

           ],
         ),


       ),
    );
  }
}
