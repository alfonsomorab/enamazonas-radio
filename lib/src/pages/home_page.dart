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
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _floatingButtonPress,
        child: play ? Icon( Icons.pause ) : Icon( Icons.play_arrow ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Container(
        color: Colors.green,
        child: _pageInformation(),
      ),
    );
  }

  _bottomNavigationBar() {

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text('Información')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.email),
          title: Text('Contacto')
        )
      ]
    );

  }

  _pageInformation() {

    return Stack(
      children: <Widget>[
        _getBackground(),
        SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox( height: 70.0,),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 90.0,
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
      ],
    );
  }

  _getBackground(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _BackgroundHeaderPainter(Colors.white, 450.0)
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


}

class _BackgroundHeaderPainter extends CustomPainter{

  final Color color;
  final double height;

  _BackgroundHeaderPainter(this.color, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    // Properties
    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;

    final path = new Path();

    // draw with paint and path
    path.lineTo(0, height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, height , size.width , height * 0.25);

    path.lineTo(size.width, 0);


    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
