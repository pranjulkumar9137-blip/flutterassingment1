//in this program we are making simple logic based voting system according to the age
import 'dart:io';
void main()
{
  stdout.write("Enter the age: ");
  int age=int.parse(stdin.readLineSync()!);
  if(age>=18)
  {
    print("You are eligible for the vote: ");
  }
  else{
    print("Your are not eligible for the vote\n");
  }
  stdout.write("Are you find largest no the press 1/0: ");
  int ch=int.parse(stdin.readLineSync()!);
  if(ch==1){
     findLargest();
  }
}
 
//In the second part of code i found the largest no between the three number
void findLargest()
{
  stdout.write("\nEnter the value of a: ");
  int a=int.parse(stdin.readLineSync()!);
  stdout.write("Enter the value of b: ");
  int b=int.parse(stdin.readLineSync()!);
  stdout.write("Enter the value of c: ");
  int c=int.parse(stdin.readLineSync()!);
  if(a>b && a>c)
  {
    print("$a is greater than $b and $c");
  }
  else if(b>a&&b>c)
  {
    print("$b is greater than $a and $c");
  }
  else{
    print("$c is greater than $a and $b");
  }
}