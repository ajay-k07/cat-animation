import 'package:flutter/material.dart';
import 'cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return HomeState();
    //throw UnimplementedError();
  }
}
class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(minutes: 1),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(
        CurvedAnimation(
            parent: catController,
            curve: Curves.easeIn
        ),
    );
    boxController = AnimationController(
        duration: Duration(seconds: 9),
        vsync: this,
    );
    boxAnimation = Tween(
        begin:pi*0.6,
        end:pi*0.65)
        .animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        boxController.reverse();
      }else if(status == AnimationStatus.dismissed){
        boxController.forward();
      }
    });
    boxController.forward();



  }
onTap(){

    if(catController.status==AnimationStatus.completed){
      boxController.forward();
      catController.reverse();

    }else if(catController.status == AnimationStatus.dismissed){
      boxController.stop();
      catController.forward();
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cat animation'),
      ),
      body: GestureDetector(
        child: Center(
          child:Stack(
          children: [
            buildAnimation(),
            buildBox(),
            buildLeftFlap(),
            buildRightFlap(),
          ],
            overflow: Overflow.visible,
        ),
        ),
        onTap: onTap,
      )
    );
    throw UnimplementedError();
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context,child){
          return Positioned(
            top:catAnimation.value,
            child: child,
            right: 0.0,
            left: 0.0,
          );
          },
        child: Cat(),
    );
  }

 Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
 }

 Widget buildLeftFlap(){
    return Positioned(
      left: 3.0,
      child:  AnimatedBuilder(animation: boxAnimation,
        builder: (context,child){
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      ),
    ) ;
  }
  Widget buildRightFlap(){
    return Positioned(
      right: 3.0,
      child:  AnimatedBuilder(animation: boxAnimation,
        builder: (context,child){
          return Transform.rotate(
            child: child,
            angle: - boxAnimation.value,
            alignment: Alignment.topRight,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      ),
    ) ;
  }


}