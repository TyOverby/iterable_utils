part of iterable_utils;

Iterable flatten(Iterable<Iterable> iter) {
  
  return concat(iter.toList());
}