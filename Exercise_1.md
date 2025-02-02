### From the example on slide 10 and 11 of Lecture 3, what would be the output for the second example (HelloWorld(uint[], bool))?

#### You can calculate the function selector with the provided algorithm on slide 11. For the memory location, you can make it up but remember to observe left and right zero padding for all inputs. (1,5 points)

Function Selector: bytes4(keccak256(bytes(function_signature)))
Memory Location: 0000000000000000000000000000000000000000000000000000000000000042
True: 0000000000000000000000000000000000000000000000000000000000000001
Array Length: 0000000000000000000000000000000000000000000000000000000000000002
1993: 00000000000000000000000000000000000000000000000000000000000007c9
1994: 00000000000000000000000000000000000000000000000000000000000007cA

### What would the encodePacked function call give you? (0,5 points)
No zero padding, no length, no memory offset, no decode equivalent due to ambiguity:

Function Selector: bytes4(keccak256(bytes(function_signature)))
True: 1
1993: 7c9
1994: 7cA