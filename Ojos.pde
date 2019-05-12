class Ojos
{
  boolean tipo;//false Izq, true Der
  float x,y,tamX,tamY;
  Ojos(boolean t, float xx, float yy, float tx, float ty)
  {
    tipo=t;
    x=xx;
    y=yy;
    tamX=tx;
    tamY=ty;
    x+=tamX/5;
    y+=tamY/5;
    tamX/=2;
    tamY/=2;
  }
  void display()
  {
    rect(x,y,tamX,tamY);
  }
}
