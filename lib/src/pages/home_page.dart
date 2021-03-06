import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const streamUrl = "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";

  AudioPlayer _player;

  bool play;

  final Color color = Colors.deepPurple;
  //int currentPage = 0;
  PageController _pageController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(
      initialPage: 0,
      keepPage: false,
    );
    _player = AudioPlayer();
    _player.setUrl( streamUrl )
      .catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print('ERROOOOOR');
      print(error);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: PageView(
        controller: this._pageController,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _firstPage(),
          _secondPage(),
        ]
      ),
    );
  }


  _firstPage() {

    return Stack(
      children: <Widget>[
        _getBackground(),
      ],
    );
  }

  _secondPage(){

    return Container(
      color: Colors.deepPurple,
      child: SafeArea(
          child: Column(

            children: <Widget>[
              SizedBox( height: 70.0,),
              Image(
                image: AssetImage('assets/logo_blanco.png'),
                height: 50.0,
                fit: BoxFit.cover,
              ),
              SizedBox( height: 160.0,),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Proyecto comunicacional alternativo que transnmite desde Amazonas Venezuela, usando Software Libre (Linux GET - G-Radio).',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Reporta tu sintonía a través de los siguientes enlaces:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/whatsapp.png'),
                    fit: BoxFit.cover,
                    height: 20.0,
                  ),
                  Text('Escríbenos por Whatsapp',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon( Icons.alternate_email,size: 30.0, color: Colors.white,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Envíanos un email',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
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
            painter: _BackgroundHeaderPainter(color , 300.0)
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
        color: Color(0xFF493952),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(3, 10), // changes position of shadow
          ),
        ],
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


  _getBottomButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _getPlayButton(),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                onPressed: (){
                  setState(() {
                    this._pageController.animateToPage( 1 ,
                      duration: Duration( milliseconds: 250 ),
                      curve: Curves.fastOutSlowIn
                    );
                  });
                },
                child: Icon( Icons.info_outline, color: Colors.white, size: 30.0),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                color: color,
                elevation: 10.0,
              ),
            ),
            Expanded(
              child: RawMaterialButton(
                onPressed: (){
                  setState(() {
                    this._pageController.animateToPage( 1 ,
                      duration: Duration( milliseconds: 250 ),
                      curve: Curves.fastOutSlowIn
                    );
                  });
                },
                child: Icon( Icons.alternate_email, color: Colors.white, size: 30.0),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                fillColor: color,
                elevation: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0,)
      ],
    );
  }

  _getPlayButton(){

    return StreamBuilder<FullAudioPlaybackState>(
      stream: _player.fullPlaybackStateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.state;
        final buffering = fullState?.buffering;

        if (state == AudioPlaybackState.connecting ||
          buffering == true)
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(),
          );
        else if (state == AudioPlaybackState.playing)
          return RawMaterialButton(
            child: Icon(Icons.pause, color: Colors.white, size: 60.0),
            onPressed: _player.pause,
            padding: EdgeInsets.all(20.0),
            shape: CircleBorder(),
            fillColor: color,
            elevation: 10.0,
          );
        else
          return RawMaterialButton(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 60.0),
            onPressed: _player.play,
            padding: EdgeInsets.all(20.0),
            shape: CircleBorder(),
            fillColor: color,
            elevation: 15.0,
          );
      }

//        return RawMaterialButton(
//          onPressed: (){
//          },
//          child: _getIconForButton(state, buffering)

//          play ? Icon( Icons.pause, color: Colors.white, size: 60.0 ) :
//          Icon( Icons.play_arrow, color: Colors.white, size: 60.0),
//          padding: EdgeInsets.all(20.0),
//          shape: CircleBorder(),
//          fillColor: Colors.deepPurple,
//          elevation: 10.0,

      ,
    );

  }

  _getIconForButton( state, buffering ){

  }
}



class _BackgroundHeaderPainter extends CustomPainter{

  final Color color;
  final double height;

  _BackgroundHeaderPainter(this.color, this.height);

  @override
  void paint(Canvas canvas, Size size) {

//    final Rect rect = new Rect.fromCircle(
//      center: Offset( size.width * 0.5 , size.height - height ),
//      radius: 140,
//    );
//
//
//
//    final Gradient gradient = new LinearGradient(colors: <Color>[
//      Color.fromRGBO(239, 27, 255, 1.0),
//      Colors.deepPurple,
//    ]);
//
//    final paint = new Paint()..shader = gradient.createShader(rect);

    final paint = new Paint();

    // Properties
    paint.color = Colors.deepPurple;
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


