library iterable_utils;

import 'dart:collection';
import 'package:range_util/range_util.dart';

part 'zip.dart';
part 'concat.dart';
part 'count.dart';
part 'flatten.dart';

main(){
  var a1 = [0,1,2,3,4,5];
  var a2 = "Hello world".split("");
  var a3 = "This is a test".split("");
  
  zip([a1,a2,a3], false).forEach(print);
  
  var a4 = "woo another test".split("");
  zipWithIndex(a4).forEach(print);
  
//  var a1 = [0,1,2,3,4,5];
//  var a2 = [6,7,8,9,10];
//  var a3 = [11,12,13,14,15];
//  
//  concat([a1,a2,a3]).forEach(print);
}