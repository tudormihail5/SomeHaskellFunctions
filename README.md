# Some Haskell Functions

### What they do:

Types.hs initialises some types and data that are going to be used by the functions.
Q3Examples initialises some examples that will be used for testing the functions.
Both files are imported by SomeHaskellFunctions.hs.

**Exercise 1:**<br />
A cupcake recipe is represented as a list of ingredients, and a cupcake is represented as a recipe together with a price. I wrote some functions to filter cupcakes by different criteria. priceRange minPrice maxPrice cupcakes returns the cupcakes whose price is between those prices. allergyFree allergens cupcakes returns the cupcakes that do not contain any allergens.<br />
<!-- -->
**Examples:**<br />
*Main> priceRange (P 200) (P 300) [CC (P 200) [Soy], CC (P 250) [Dairy], CC (P 400) [Nuts,Gluten]]<br />
[CC (P 200) [Soy],CC (P 250) [Dairy]]<br />
*Main> allergyFree [Dairy,Nuts] [CC (P 200) [Soy], CC (P 250) [Dairy], CC (P 400) [Nuts,Gluten]]<br />
[CC (P 200) [Soy]] 

**Exercise 2:**<br />
I needed to add an additional step of checking that every tin satisfies some formal specification before it is baked. A tin satisfies And s1 s2 if it satisfies both s1 and s2, Or s1 s2 if either s1 or s2, etc. I had to write a function isValidSpec that verifies that the given specification is well-formed for the provided Tin, and checkSpecs, which takes a specification s and a tin t as imputs, and returns True just in case t satisfies the specification s, or else False.<br />
<!-- -->
**Examples:**<br />
sampletin :: Tin<br />
sampletin = [[Nuts], [Dairy,Gluten], [], [Soy]]<br />
satisfies the specification<br />
And (HasCup 0 Nuts) (And (HasCup 1 Gluten) (And (Not (HasCup 2 Dairy)) (HasCup 3 Soy)))<br />
but does not satisfy the specification<br />
Or (HasCup 0 Dairy) (HasCup 1 Soy)<br />
Moreover, the 2 above specifications are valid, while the specifications<br />
And (HasCup 0 Nuts) (And (HasCup (-2) Gluten) (And (Not (HasCup 2 Dairy)) (HasCup 3 Soy)))<br />
Or (HasCup 0 Dairy) (HasCup 4 Soy) 

**Exercise 3:**<br />
In this exercise, I developed an auxiliary data type for navigating the directory structure, to enter a subdirectory by keeping the list of entries above and below the subdirectory we choose. This is represented by yhe type EnteredDirectory. A Breadcrumb is a pair of a directory (the one that we are currently looking at which we will call the 'focus') and a list of entered directories. parentDir passes to the parent directory and returns Nothing if it is not the root. openSubDir takes a directory name and attempts to find in the currently focused directory, making it the new focus. The function will return Nothing if the subdirectory can not be found.<br />
<!-- -->
**Examples:**<br />
*Main> parentDir bc1 == Just bc2<br />
True<br />
*Main> openSubDir "french" (recipes, []) == Just bc0<br />
True<br />
*Main> openSubDir "tex-mex" (recipes, []) == Nothing<br />
True

**Exercise 4:**<br />
This exercise is about the Sieve of Eratosthenes. The main goal was to define an infinite list of booleans such that, for any given n >= 2, we have sieve !! (n-2) = True if and only if n in prime. cross, for every n >= 2 and every infinite list xs, we have that cross n xs crosses out the elements of xs, by setting them to False, every n elements, starting from position n-1 and keeping all other positions as they are in the list xs. sieveFrom n is the transformation we need to make to out infinite list as we pass the number n. Using sieveFrom, I needed to define sieve :: [Bool]. Finally, function sequenceFrom was defined such that the list of all prime numbers can be given by the funtion primes :: [Int].<br />
<!-- -->
**Examples:**<br />
*Main> take 20 (cross 2 (repeat True))<br />
[True,False,True,False,True,False,True,False,True,False,True,False,True,False,True,False,True,False,True,False]<br />
*Main> take 20 (cross 3 (repeat True))<br />
[True,True,False,True,True,False,True,True,False,True,True,False,True,True,False,True,True,False,True,True]<br />
*Main> take 20 (sequenceFrom 2 (cross 5 (repeat True)))<br />
[2,3,4,5,6,7,8,10,12,13,14,15,17,18,19,20,22,23,24,25]<br />
*Main> take 20 (sequenceFrom 2 (cross 2 (repeat True)))<br />
[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40]<br />
*Main> take 10 primes<br />
[2,3,5,7,11,13,17,19,23,29]

### How I built them:

For every exercise I created some helping functions:
- For Exercise 1, I created comp, that checks if a certain element is in a list.
- Using comp, I created nothingEq, that checks if any list element is duplicate.
- Then I used these 2 functions to create allergyFree, as for priceRange I did not need any help.
<!-- -->
- For Exercise 2, I created hasElem, that checks if a list has a certain element.
- Using this, I created checkSpec, using the function for the 'HasCup x y' case, as the other ones could be done using logical operations, like and, or, and not.
- isValidSpec needed logical operations as well, but the 'HasCup x y' case only needed me to check if the length of z is bigger than x, when x is positive.
<!-- -->
- For Exercise 3, I created strings, which takes a list of  DirectoryEntry and extracts their names, returning a list of strings.
- name, given a string s and a list of DirectoryEntry, it extracts and returns the name of the entry
- before, given a string s and a list of DirectoryEntry, it returns a list of entries that appear before the first occurence of s in the list.
- after returns a list of entries that appear after the i-th occurence of s in the list.
- dir searches for an entry with the name s and returns the corresponding Directory if found.
- parentDir takes a Breadcrumb and returns Maybe Breadcrumb. If the Breadcrumb is empty, it returns Nothing. Otherwise, it constructs a new breadcrumb by moving up one directory, removing the last entered directory.
- openSubDir takes a string s and a Breadcrumb. It checks if s exists in the current directory's contents. If it does, it constructs a new breadcrumb by entering the subdirectory specified by s.
<!-- -->
- For Exercise 4, I created help, that helps me with cross, doing almost the same thing, but with one more number, that is 0 at the beginning, and is increased by 1, until the list is over. This helped me to put 'False' in the right positions of the list.
- help'' was done to help me create sieveFrom, in the same way as help; sieveFrom uses cross to create the list of booleans needed for the primes.
- sieve returns the infinite list of booleans that we need, using sieveFrom.
- Finally, help' is helping sequenceFrom to create the list of primes that we need, returning the position of every 'True' in the list, and the additional number, constantly increased by 1, is helping me record the position we are at.
- primes is the final product of this exercise, that uses sequenceFrom and sieve to return the infinite list of prime numbers, beggining with 2, as it is the smallest positive number.

### Challenges I ran into:

I found Exercise 4 the hardest one by far, as it requested many functions. But this was not the main problem. It took me a while to properly understand what I am supposed to do. But after some research on the Sieve of Eratosthenes, everything worked smoothly.
