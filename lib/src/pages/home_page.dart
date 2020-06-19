import 'package:flutter/material.dart';
import 'package:url_audio_stream/url_audio_stream.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static AudioStream stream = new AudioStream("https://radios.yanapak.org/enamazonas");
  bool play = true;

  @override
  Widget build(BuildContext context) {

    callAudio("start");

    return Scaffold(

      body: Container(
        color: Colors.green,
        child: _pageInformation(),
      ),
    );
  }


  _pageInformation() {

    return Stack(
      children: <Widget>[
        _getBackground(),
//        SafeArea(
//          child: Column(
//            children: <Widget>[
//              SizedBox( height: 70.0,),
//              Image(
//                image: AssetImage('assets/logo.png'),
//                height: 90.0,
//                fit: BoxFit.cover,
//              ),
//              SizedBox( height: 160.0,),
//              Container(
//                padding: EdgeInsets.all(20.0),
//                child: Text('Proyecto comunicacional alternativo que transnmite desde Amazonas Venezuela, usando Software Libre (Linux GET - G-Radio).',
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.white
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.all(20.0),
//                child: Text('Reporta tu sintonía a través de los siguientes enlaces:',
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.white
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              SizedBox(
//                height: 20.0,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Image(
//                    image: AssetImage('assets/whatsapp.png'),
//                    fit: BoxFit.cover,
//                    height: 20.0,
//                  ),
//                  Text('Escríbenos por Whatsapp',
//                    style: TextStyle(
//                      fontSize: 18.0,
//                      color: Colors.white
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 15.0,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Icon( Icons.alternate_email,size: 30.0, color: Colors.white,
//                  ),
//                  Container(
//                    margin: EdgeInsets.symmetric(horizontal: 20.0),
//                    child: Text('Envíanos un email',
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        color: Colors.white
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              Expanded(
//                child: Container(),
//              ),
//            ],
//          ),
//        ),
      ],
    );
  }

  _getBackground(){

    final background = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[
            Color.fromRGBO(62, 60, 80, 1.0),
            Color.fromRGBO(35, 36, 48, 1.0),
        ]),
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(
          top: 100,
          left: MediaQuery.of(context).size.width * 0.15,
          child: _getCircle()
        ),
        Center(

          child: Container(
            margin: EdgeInsets.only(top: 150.0, left: 30.0, right: 30.0),

            child: Image(
              image: AssetImage('assets/logo_blanco.png'),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            //Color.fromRGBO(239, 27, 255, 1.0)
            painter: _BackgroundHeaderPainter(Colors.deepPurple , 300.0)
          ),
        ),

        _getBottomButtons(),
      ],
    );
  }

  Widget _getCircle(){
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.5),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image(
          image: AssetImage('assets/mic.png'),
          fit: BoxFit.cover,
          height: 100.0,
        ),
      ),
    );
  }

  _pageContact() {

    return Center(
      child: Container(
        child: Text('Page 2'),
      ),
    );
  }

  Future<void> callAudio(String action) async{
    if(action == "start"){
      stream.start();
    }else if(action == "stop"){
      stream.stop();
    }else if(action == "pause"){
      stream.pause();
    }else{
      stream.resume();
    }
  }

  void _floatingButtonPress() {
    setState(() {
      play = !play;
    });

    if (play){
      callAudio('start');
    }
    else{
      callAudio('stop');
    }
  }

  _getBottomButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: (){},
          child: Icon( Icons.play_arrow, color: Colors.white, size: 60.0),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
          fillColor: Colors.deepPurple,
          elevation: 10.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RawMaterialButton(
                onPressed: (){},
                child: Icon( Icons.info_outline, color: Colors.white, size: 30.0),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                fillColor: Colors.deepPurple,
                elevation: 10.0,
              ),
            ),
            Expanded(
              child: RawMaterialButton(
                onPressed: (){},
                child: Icon( Icons.alternate_email, color: Colors.white, size: 30.0),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                fillColor: Colors.deepPurple,
                elevation: 10.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0,)
      ],
    );
  }


}

class _BackgroundHeaderPainter extends CustomPainter{

  final Color color;
  final double height;

  _BackgroundHeaderPainter(this.color, this.height);

  @override
  void paint(Canvas canvas, Size size) {

    final Rect rect = new Rect.fromCircle(
      center: Offset(10,50),
      radius: 180,
    );

    final Gradient gradient = new LinearGradient(colors: <Color>[
      Color.fromRGBO(239, 27, 255, 1.0),
      Colors.deepPurple
    ]);

    final paint = new Paint()..shader = gradient.createShader(rect);

    // Properties
    //paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;

    final path = new Path();

    // draw with paint and path
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - height * 0.25);
    path.quadraticBezierTo( size.width * 0.5, size.height - height , size.width , size.height - height * 0.25 );

    path.lineTo(size.width, size.height);


    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
