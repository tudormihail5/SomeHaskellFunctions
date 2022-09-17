# Some Haskell Functions

### What they do:

Types.hs initialises some types and data that are going to be used by the functions.
Q3Examples initialises some examples that will be used for testing the functions.
Both files are imported by SomeHaskellFunctions.hs.

**Exercise 1:** 
A cupcake recipe is represented as a list of ingredients, and a cupcake is represented as a recipe together with a price. I wrote some functions to filter cupcakes by different criteria. priceRange minPrice maxPrice cupcakes returns the cupcakes whose price is between those prices. allergyFree allergens cupcakes returns the cupcakes that do not contain any allergens.
**Examples:**

*Main> priceRange (P 200) (P 300) [CC (P 200) [Soy], CC (P 250) [Dairy], CC (P 400) [Nuts,Gluten]]
[CC (P 200) [Soy],CC (P 250) [Dairy]]
*Main> allergyFree [Dairy,Nuts] [CC (P 200) [Soy], CC (P 250) [Dairy], CC (P 400) [Nuts,Gluten]]
[CC (P 200) [Soy]]

**Exercise 2:**
I needed to add an additional step of checking that every tin satisfies some formal specification before it is baked. A tin satisfies And s1 s2 if it satisfies both s1 and s2, Or s1 s2 if either s1 or s2, etc. I had to write a function isValidSpec that verifies that the given specification is well-formed for the provided Tin, and checkSpecs, which takes a specification s and a tin t as imputs, and returns True just in case t satisfies the specification s, or else False.
**Examples:**

sampletin :: Tin
sampletin = [[Nuts], [Dairy,Gluten], [], [Soy]]
satisfies the specification
And (HasCup 0 Nuts) (And (HasCup 1 Gluten) (And (Not (HasCup 2 Dairy)) (HasCup 3 Soy)))
but does not satisfy the specification
Or (HasCup 0 Dairy) (HasCup 1 Soy)
Moreover, the 2 above specifications are valid, while the specifications
And (HasCup 0 Nuts) (And (HasCup (-2) Gluten) (And (Not (HasCup 2 Dairy)) (HasCup 3 Soy)))
Or (HasCup 0 Dairy) (HasCup 4 Soy)

**Exercise 3:**

### How I built them:



### Challenges I ran into:
