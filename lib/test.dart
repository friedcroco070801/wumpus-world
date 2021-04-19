import 'dart:async';

class AsyncCheck {
  bool asyncCheck;
  AsyncCheck() {
    asyncCheck = false;
  }
  void setCheck(bool temp) {
    asyncCheck = temp;
  }

  bool check() {
    return asyncCheck;
  }
}

void changed(AsyncCheck asyncCheck) {
  asyncCheck.setCheck(true);
}

void main() {
  // AsyncCheck asyncCheck = AsyncCheck();
  // print(asyncCheck.check());
  // Timer timer = Timer(Duration(milliseconds: 5), () {
  //   changed(asyncCheck);
  //   print('In timer:' + asyncCheck.check().toString());
  // });

  // bool check = timer.isActive;
  // while (check) {
  //   check = timer.isActive;
  // }
  bool temp = false;
  Timer(Duration(milliseconds: 5), () {
    print('In timer:' + temp.toString());
    temp = true;
  });

  while (!temp) {}
  print('End');

  Timer(Duration(milliseconds: 1000), () {
    print('In timer:' + temp.toString());
  });
}
