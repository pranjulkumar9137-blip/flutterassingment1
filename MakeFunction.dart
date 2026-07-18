import 'dart:ffi';
import 'dart:io';
//in this program we make a user define function and call the function

//in this add function without return type and without parameter 
 
void add()
{
  stdout.write("Enter the value of a: ");
  int a=int.parse(stdin.readLineSync()!);
  stdout.write("Enter the value of b: ");
  int b=int.parse(stdin.readLineSync()!);
  int sum=a+b;
  print("The sum of $a and $b is ${a+b}");
}
//without return type with parameter
void sub(int a,int b){
    print("The multiplication of $a and $b is ${a-b}");
}
//with return type and with parameter
int muti(int x,int y)
{
  var mul=x*y;
  return mul;
}

//without parameter and with returntype
double divide()
{
  stdout.write("Enter the value of a: ");
  int a=int.parse(stdin.readLineSync()!);
  stdout.write("Enter the value of b: ");
  int b=int.parse(stdin.readLineSync()!);
  if(b==0)
  {
    return 0.0;
  }
  return a/b;
}


void main(){
  var count=4;
  do{
  print("\n\npesss 1 for addition\npress 2 for subtraction");
  print("press 3 for multiplication\npress 4 for the divide");
  stdout.write("Enter the choice: ");
  var ch=int.parse(stdin.readLineSync()!);
  switch(ch)
  {
    case 1:
       add();
       break;
    case 2:
      stdout.write("Enter the value of a: ");
      int a=int.parse(stdin.readLineSync()!);
      stdout.write("Enter the value of b: ");
      int b=int.parse(stdin.readLineSync()!);
      sub(a,b);
       break;
    case 3:
      stdout.write("Enter the value of a: ");
      int a=int.parse(stdin.readLineSync()!);
      stdout.write("Enter the value of b: ");
      int b=int.parse(stdin.readLineSync()!);
      int result=muti(a, b);
      print("The multiplication of $a and $b is $result");
    
    case 4:
      print("The result is: ${divide()}") ;
  }
  count--;
  }while(count!=0);
  
}