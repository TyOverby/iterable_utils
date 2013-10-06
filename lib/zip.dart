part of iterable_utils;

// TODO(tyoverby): make this not actually take a list of iterables to zip, but just an iterable of iterables.
// then flatten would be a simple mirror of it.

abstract class _ZippedIterator extends Iterator<List> {
  List<Iterator> _iters; 
  _ZippedIterator(this._iters);
  
  List _cur = null;
  
  List get current {
    return _cur;
  }
  
  bool get starting;
  bool op(bool a, bool b); 
  
  bool moveNext() {
    var safe = starting;
    
    _cur = new List.generate(_iters.length, (int i){
      safe = op(safe, _iters[i].moveNext());
      if(!safe){
        return null;
      }
      return _iters[i].current;
    }, growable: false);
    
    if(!safe) {
      _cur = null;
    }
    
    return safe;
  }
}

class ShortZippedIterator extends _ZippedIterator{
  ShortZippedIterator(List<Iterator> its): super(its);
  bool get starting => true;
  bool op(bool a, bool b) => a && b;
}

class FullZippedIterator extends _ZippedIterator{
  FullZippedIterator(List<Iterator> its): super(its);
  bool get starting => false;
  bool op(bool a, bool b) => a || b;
}

class _ShortZippedIterable extends Iterable<List> with IterableMixin<List> {
  List<Iterable> iters;
  _ShortZippedIterable(this.iters);
  
  Iterator<List> get iterator {
    return new ShortZippedIterator((this.iters.map((a) => a.iterator).toList(growable: false)));
  }
}

class _FullZippedIterable extends Iterable<List> with IterableMixin<List> {
  List<Iterable> iters;
  _FullZippedIterable(this.iters);
  
  Iterator<List> get iterator {
    return new FullZippedIterator((this.iters.map((a) => a.iterator).toList(growable: false)));
  }
}

Iterable<List> zip(List<Iterable> iters, [earlyTruncate = true]) {
  if(earlyTruncate){
    return new _ShortZippedIterable(iters);
  } else {
    return new _FullZippedIterable(iters);
  }
}

Iterable<List> zipWithIndex(Iterable iter) {
  return zip([new Range.infinite(), iter]);
}