#ifndef HEAP_H
#define HEAP_H
/* File heap.h - Abstract Base Class for Heaps
 * ----------------------------------------------------------------------------
 *  Shane Saunders
 */

#include <stdexcept> // runtime_error


/* --- Heap --- 
 * This is an abstract base class from which specific heap classes can be
 * derived.  Different heaps derived from this abstract base class can be used
 * interchangeably by algorithms that were written using the universal
 * interface it provides.
 *
 * This heap stores integer items, and associates with each item a double
 * key.  Any derived heap heap must provide the following methods:
 *
 * deleteMin()    - removes the item with the minimum key from the heap, and
 *                  returns it.
 * insert()       - inserts an item 'item' with key 'key' into the heap.
 * decreaseKey()  - decreases the key of item 'item' to the new value newKey.
 * nItems()       - returns the number of items currently in the heap.
 * nComps()       - returns the number of key comparison operations.
 * dump()         - prints a text representation of the heap to the standard
 *                  output.
 */
class Heap {
    public:
        virtual ~Heap(){}
        virtual unsigned int deleteMin() = 0;
        virtual void insert(unsigned int item, double key) = 0;
        virtual void decreaseKey(unsigned int item, double newKey) = 0;
        virtual unsigned int nItems() const = 0;
        virtual long int nComps() const = 0;
        virtual void dump() const = 0;
};

class HeapDesc {
    public:
        virtual ~HeapDesc(){}
        virtual Heap *newInstance(unsigned int n) const = 0;
};

template <class T>
class HeapD: public HeapDesc {
    public:
        Heap *newInstance(unsigned int n) const { return new T(n); }
};


#endif
