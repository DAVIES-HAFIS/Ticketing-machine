import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class TipCalcHomePage extends StatefulWidget {
  @override
  _TipCalcHomePageState createState() => _TipCalcHomePageState();
}

class _TipCalcHomePageState extends State<TipCalcHomePage> {
  int _personCount = 1;
  int _tipPercentage = 0;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.store,color: Colors.white,size: 30,),
        backgroundColor: Colors.deepPurple,
        title: Text("RESTAURANT TICKETING DEVICE", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
     body: Container(
       margin: EdgeInsets.only(top: 10.h),
       alignment: Alignment.center,
       color:Colors.white,
       child: ListView(
         scrollDirection: Axis.vertical,
         padding: EdgeInsets.all(20.5),
         children: [
           Container(
             width: 80.w,
               height:  15.h,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(20.0),
              ),
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Total Per Person",style: TextStyle(fontSize: 15.0,color: Colors.white60),),

                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Text("\$ ${calculateTotalPerPerson(_personCount,_billAmount,_tipPercentage)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.deepPurple),),
                   ),
                 ],
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(top:10.h),
             padding: EdgeInsets.all(20.0),
             decoration: BoxDecoration(
               color: Colors.transparent,
               border: Border.all(color: Colors.deepPurple,style: BorderStyle.solid),
               borderRadius: BorderRadius.circular(10.0),
             ),
             child: Column(
               children: [
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.grey,fontSize: 18),
                  decoration: InputDecoration(
                    prefixText: "Bill Amount: ",
                    prefixIcon: Icon(Icons.attach_money_outlined,size: 18,)
                  ),
                  onChanged: (String value){
                    try{
                      _billAmount = double.parse(value);
                    }catch(exception){
                      _billAmount = 0.0;
                    }

                  },
                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Split",style: TextStyle(color: Colors.grey.shade700),),
                       Row(
                         children: [
                           InkWell(
                             onTap: (){
                               setState(() {
                                 if(_personCount>1){
                                   _personCount--;
                                 }
                                 else{
                                   return null;
                                 }
                               });
                             },
                             child: Container(
                               width: 40.0,height: 40.0,margin: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7.0),
                                 color: Colors.purple.withOpacity(.1),
                               ),
                               child: Center(child: Icon(Icons.remove,color: Colors.deepPurple,size: 17,)),
                             ),
                           ),
                           Text("$_personCount",style: TextStyle(color: Colors.deepPurple,fontSize: 17,fontWeight: FontWeight.bold),),
                           InkWell(
                             onTap: (){
                               setState(() {
                                 if(_personCount>=1){
                                   _personCount++;
                                 }
                                 else{
                                   return null;
                                 }
                               });
                             },
                             child: Container(
                               width: 40.0,height: 40.0,margin: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7.0),
                                 color: Colors.purple.withOpacity(.1),
                               ),
                               child: Center(child: Icon(Icons.add,color: Colors.deepPurple,size: 17,)),
                             ),
                           ),
                         ],
                       ),

                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Tip",style: TextStyle(color: Colors.grey.shade700),),
                       Text("\$ ${calculateTotalTip(_billAmount, _personCount, _tipPercentage)}",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 17.0),)
                     ],
                   ),
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("$_tipPercentage%",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 17.0)),
                     Slider(value: _tipPercentage.toDouble(), onChanged:(double value)
                     {
                       setState(() {
                         _tipPercentage = value.round();
                       });
                     },
                       min: 0,
                       max: 100,
                       divisions: 20,
                       activeColor: Colors.purpleAccent,
                       inactiveColor: Colors.black,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("\$ ${calculateTotalBill(_personCount,_billAmount,_tipPercentage)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.blueGrey),),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
    );
  }
  calculateTotalPerPerson( int splitBy, double billAmount, int tipPercentage){
    var totalPerPerson =(calculateTotalTip(billAmount, splitBy, tipPercentage)+billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalBill( int splitBy, double billAmount, int tipPercentage){
    var totalBill =(calculateTotalTip(billAmount, splitBy, tipPercentage)+billAmount);
    return totalBill.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;
    if(billAmount < 0 || billAmount.toString().isEmpty){

    }
    else{
      totalTip = (billAmount * tipPercentage)/100;
    }
    return totalTip;
  }

}
