class Meow {
  bool k;
  Meow(this.k);
}

class Cam {
  Meow a;
  int nan;
  Cam(this.a, this.nan);
  void doThis() {
    a.k = true;
  }
}

void main() {
  Meow meof = Meow(false);
  print(meof.k);
  Cam temp = Cam(meof, 19);
  temp.doThis();
  print(meof.k);
}
