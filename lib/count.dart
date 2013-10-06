part of iterable_utils;

int count(Iterable iter, bool predicate(Object o)) {
  return iter.map((a) => predicate(a) ? 1 : 0).fold(0, (a,b)=>a+b);
}