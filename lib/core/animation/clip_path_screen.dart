import 'package:flutter/material.dart';

class ClipPathScreen extends StatefulWidget {
  const ClipPathScreen({Key? key}) : super(key: key);

  @override
  State<ClipPathScreen> createState() => _ClipPathScreenState();
}

class _ClipPathScreenState extends State<ClipPathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: CustomClipPath(),
              child: Container(
                height: 400,
                width: double.infinity,
                color: Colors.lightBlue,
                child: const Center(
                  child: Text("Clip Path",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: CustomClipPath2(),
              child: Container(
                height: 400,
                width: double.infinity,
                color: Colors.lightBlue,
                child: const Center(
                  child: Text("Clip Path",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h-100, w, h);
    path.lineTo(w, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}

class CustomClipPath2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, h);
    // path.quadraticBezierTo(w*0.5, h, w, h*0.8);
    path.quadraticBezierTo(0, h, w, h*0.8);
    path.lineTo(w, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}
