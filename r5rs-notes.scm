#!

3.2. Disjointness of types

No object satisfies more than one of the following:

boolean?
symbol?
char?
vector?
procedure?
pair?
number?
string?
port?


4.1.4. Procedures

lambda may have the following form:

(lambda x x)

x may be any number of arguments. When the procedure is called, the sequence of arguments is converted into a newly allocated list.


4.2.1. Conditionals

cond may have clauses like:

(<test> => <expression>)

where expression is a procedure of one argument. The procedure is called on the value of the test, and the value returned is the value of the cond expression.
!#

(cond ((assv 'b '((a 1) (b 2))) => cadr))
;;; >> 2

#!

4.2.1. Conditionals

(case <key> <clause1> <clause2> ...)

a <clause> is ((<datums> ...) (expressions) ...)

<key> is evaluated and compared against <datum> in the sense of eqv?.
!#

(case (* 2 3)
  ((2 3 5 7) 'prime)
  ((1 4 6 8 9) 'composite))
;;; >> composite

#!

4.2.2. Binding constructs

Though there is a restriction on letrec (it must be possible to evaluate each <init> without assigning or referring to the value of any <variable>), in most common uses of letrec, all the <init>s are lambda expressions, and this restriction is automatically satisfied.


4.2.4. Iteration

(do ((<variable1> <init1> <step1>)
     ...)
    (<test> <expression> ...)
  <command> ...)

Named let
(let <variable> <bindings> <body>)

<variable> is bound to a procedure whose formal arguments are the bound variables and whose body is <body>
#!


4.2.5. Delayed evaluation

(delay <expression>) is used with force to implement lazy evaluation.


6.1. Equivalence predicates

eqv? returns #t if the two arguments should normally be regarded as the same boolean, symbol, character, or number of the same type. For pairs, vectors, or strings, they must be in the same location in the store.

eq? tests the pointers of the two arguments.

equal? is the least discriminating. It recursively compares the contents of pairs, vectors, and strings. A rule of thumb is that objects are generally equal? if they print the same.


6.3.2. Pairs and lists

(memq obj list), memv, and member use eq?, eqv?, and equal? to test for membership of an object in a list. If it is not found, #f is returned.

(assq obj alist), assv, and assoc returns the first pair in an alist (association list) whose car is the given object.

An alist is a list of pairs '((a 1) (b 2) (c 3)).

!#
