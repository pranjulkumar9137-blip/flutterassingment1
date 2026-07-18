//in this program i take the user input and find the product and sum of the user
import 'dart:io';
void main()
{
  print("Enter the value of a: ");
  int a=int.parse(stdin.readLineSync()!);
  print("Enter the value of b: ");
  int b=int.parse(stdin.readLineSync()!);
  print("The value of a&b is: ${a*b}");
}
