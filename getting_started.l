/// These are documentation comments

    /*
        This is a multi-line comment
        that can go on for as long as you want,
        it can also be inlined with code
    */
    // This is a single line comment that can appended to the end of a line of code

/// General assignment

    // NOTE: Keywords var and del and explained here
    // NOTE: Operators =, ;, and => are explained here
    // NOTE: ERROR: codes mean that the program will panic and exit if run

    // Variables are immutable by default
        var x = 13;             // 13
        // x = 44;              // ERROR: Attempting to assign 44 to the immutable value "x"!
        // var x = 44;          // ERROR: Attempting to redeclare the immutable value "x"!

    // Semi-colons are required to end statements
        // var x = 13           // ERROR: Missing semi-colon!

    // Freeing previously declared variables
        del x;
        // del x;               // ERROR: Attempting to delete the non-existent value "x"!
        // x = 44;              // ERROR: Attempting to assign 44 to the non-existent value "x"!
        var x = 44;

    // Mutable values are prefixed with _
        var _x = 12;    // 12
        _x = 1;         // 1

    // Copying values
        var _y = _x;    // 1 - a copy of _x's value was made
        _y = 2;         // 2 
        var _z = _x;    // 1

    // Referencing values
        var reference_to_x => _x;   // 1
        _x = 3;                     // 3
        _y = reference_to_x;        // 3 - reference_to_x naturally dereferences itself
        _x = 4;                     // 4
        _z = _y;                    // 3 - _y copied the value of _x before it was changed

    // Borrowing values
        var borrowing_x => @_x;     // 4 we're borrowing whatever's @ _x
        @borrowing_x = 5;           // 5 is assigned @ the reference's address
        _z = x;                     // 5

    // Values cannot be borrowed from immutable variables
        // var borrowing_y => @x;   // ERROR: Cannot borrow from an immutable value, "x" is immutable, reference it instead!

    // Ownership
        // _x = 7;                  // ERROR: Cannot change a borrowed value, "borrowing_x" has it!
        // var thief = @_x;         // ERROR: Cannot borrow a borrowed value, "borrowing_x" has it!
        del borrowing_x;            // We can delete a borrowed value to return ownership
        _x = 7;                     // 7

    // Dangers of non-constant references
        var _greedy => @_x;         // 5
        _greedy => @_y;             // _x has been returned
        _x = 10;                    // 10
        _greedy = 12;               // _greedy no longer references anything and simply has the value 12

    // References to nothing
        // del _x;                  // ERROR: Cannot delete a value with active references, [reference_to_x] must be deleted first!

/// Arithmetic 

    // NOTE: Increment and decrement operators are not supported
    // NOTE: [operator]= was begrudgingly added and may be removed in the future
    // NOTE: Bitwise operators are not supported 

    // Addition
        var _number = 12 + 12;      // 24
        _number += 12;              // 36
    // Subtraction
        _number = _number - 12;     // 24
        _number -= 12;              // 12
    // Multiplication
        _number = _number * 2;      // 24
        _number *= 2;               // 48
    // Division
        _number = _number / 2;      // 24
        _number /= 2;               // 12
    // Modulo
        _number = _number % 7;      // 5
        _number %= 3;               // 2


/// Logic

    // NOTE: Yoda conditions are idomatic in this language

    var _boolean = true;
    // Negate
        _boolean = !_boolean;       // false
    // And
        _boolean = true  && _boolean; // false
    // Or
        _boolean = false || _boolean; // false
    // Xor
        _boolean = true  ^^ _boolean; // true

/// Comparison

    // Equality
        _boolean = 12 == 12;        // true
        _boolean = 12 != 12;        // false
    // Less than
        _boolean = 12 < 12;         // false
        _boolean = 12 <= 12;        // true
    // Greater than
        _boolean = 12 > 12;         // false
        _boolean = 12 >= 12;        // true

/// Key Tables

    // Creating a keyed table
        var Bob = [
            var name = "Robert",
            var _age = 32
        ];

    // Accessing values
        "Robert" == Bob.name;       // true - Dot notation
        32       == Bob["_age"];    // true - Bracket notation
        "Robert" == Bob[0];         // true - Index notation works as tables are ordered

    // All rules from general assignment apply here
        // Bob = 12;                // ERROR: Attempting to assign 12 to the immutable value "Bob"!
        // Bob.name = 12;           // ERROR: Attempting to assign 12 to the immutable value "Bob.name"!
        Bob._age = 33;              // 33

    // Using variables
        var age_index = 1;
        33 == Bob[age_index];       // true

    // 'var' is implied and not required
        var _John = [
            name = "John",
            _age = 27
        ];

    // New values can be added and will be appended to the end of the table by default
        var _John.email = "john321@email.com";  // [ name = "John", _age = 27, email = "john321@email.com" ]
    // Specific fields can be removed
        del _John._age;                         // [ name = "John", email = "john321@gmail.com"]

/// Keyless Tables
    // Creating keyless tables
        var _Array  = [0, 1, 2];         
        var C       = [5, 6];

    // Accessing values
        0 == _Array[0];             // true
        6 == C[1];                  // true

    // Concatenation
        _Array = _Array & [3];          // [0, 1, 2, 3]
        _Array = C & _Array;            // [5, 6, 0, 1, 2, 3]

    // Slicing
        var End = _Array | 3;                   // [1, 2, 3]
        var Start = _Array[5] + 1 | _Array;     // [5, 6, 0, 1] - Expressions can be used to define the start and end

    // Selections
        var _Range = _Array[2~4];       // [0, 1, 2]
        var Alt_End = _Array[3~];       // [1, 2, 3]
        var Alt_Start = _Array[~3];     // [5, 6, 0, 1]

    // Keyed tables follow the same rules
        _John = _John & [phone = "123-456-7890"];
        var John_Contact_Info = _John[2~3];    // [email: "john321@email.com", phone: "123-456-7890"]

/// Blocks

    // NOTE: WARNING: Will output a message to the terminal but will not panic the program

    // Blocks are declared with curly braces
        {
            var local_variable = 12;            // WARNING: This variable is not used!
            // del local_variable;              // This is called automatically when the block ends
        }
    
    // Unused variables will not throw an error, but it will leave squiggly lines in the editor
        {
            var _unused_variable = 12;
            _ = _unused_variable;               // The _ keyword is used to discard values
        }

    // Blocks can be nested
        {
            var _local_variable = 12;
            {
                var _nested_variable = 13;
                _local_variable += nested_variable; 
            }
            25 == _local_variable;              // true
        }

    // Blocks obey the same rules as general assignment
        {
            var _outer_variable = 12;
            {
                var _inner_variable = 13;
                _outer_variable => _inner_variable;
        //  }                                           // ERROR: Cannot delete a value with active references, [_outer_variable] must be deleted first!
                del _outer_variable;
            }
        }

    // Returning values from blocks
        var simple_return = { return 32; };
        32 == simple_return;                    // true

    // Return values exit the block immediately
        var return_value = {
            var _local_variable = 12;
            return _local_variable;
            _local_variable = 13;               // This is unreachable
        }
        12 == return_value;                    // true

    // Blocks can be defined using : and run using the run keyword
        var block: {
            var local_variable = 32;
            return local_variable;
        }
        32 == run block;                        // true

    // We can defer certain logic until later
        var deferred_result = {
            var _deferred_value = 5;
            var end_logic: {
                _deferred_value *= 3;
            }
            _deferred_value += 2;
            run end_logic;
            return _deferred_value;
        }
        21 == deferred_result;                 // true

    // Alternatively, we can use the defer keyword
        var easier_defferal = {
            var _deferred_value = 5;
            defer { _delayed_variable *= 3; }
            _delayed_variable += 2;
            return _delayed_variable;
        }
        21 == easier_defferal;                  // true

    // Defer is pushed on a stack and popped off one at a time
        var nested_result = {
            var _nested_variable = 5;
            defer { _nested_variable = _nested_variable * 3; }  // This will be run last
            _nested_variable -= 2;
            defer { _nested_variable = _nested_variable + 1; }  // This will be run first
            return _nested_variable;
        }
        nested_result == 12;                 // true

    // Defers only run if they are executed first
        var tardy_result = {
            var _tardy_variable = 5;
            return _tardy_variable;
            defer { _tardy_variable *=3; }
        }
        5 == tardy_result;                  // true

/// Functions

    // We can turn a block into a proper function by passing in arguments
        var add_one: (value) {
            return value + 1;
        }
        13 == run add_one (12);             // true

    // Parentheses replace the need for the run keyword
        var _function_value = add_one (_function_value);        // 13

    // And we can even run a block using this syntax
        32 == block ();                                     // true
    
    // By default only a reference to a value is passed to a function
        var invalid_changer: (value) {
            // value = 12;                                     // ERROR: value was not borrowed!
        }

    // Using the same logic as a borrowed reference, we can pass in a reference to a value
        var valid_changer: (@value) {
            @value = 7;
        }
        valid_changer (@_function_value);
        7 == _function_value;                               // true
    

/// Control Flow    

    // NOTE: There is no else statement in this language
    // NOTE: There is no ternary operator in this language
    
    // Prefixing a block of code with an if statement will execute the block IF the condition is true
        var _boolean_result = 0;
        if ( 12 > 5 ) {
            _boolean_result += 1;
        }
        if (false) {
            _boolean_result += 2;
        }
        1 == _boolean_result;               // true



    // Return rules are consistent
        var _if_value = 12;
        _if_value = if ( _if_value < 32 ) { return 32; };
        32 == _if_value;                    // true

    // Bubbling up return values
        var bubble_value = {
            if (true) {
                return 21;
            }
            return 13;
        }
        21 == bubble_value;                 // true

    // Bubbling values will continue until they find a non-conditional scope to return from
        var deep_bubble = {
            if (true) {
                if (true) {
                    if (true) {
                        return 3;
                    }
                }
            }
            return 5;
        }
        3 == deep_bubble;                       // true
    // NOTE: Please don't do this.

    // Interception of return values
        var intercepted_value = {
            _ = if (true) {
                return 21;
            }
            return 13;
        }
        13 == intercepted_value;              // true
    
    // You can skip to the end of the current block using the continue keyword;
        var skipped_value = {
            _ = if (true) {
                continue;
                return 21;
            }
            return 13;
        }
        13 == skipped_value;                  // true

    // Keep in mind that continue follows the bubble convention but stops at the end of the final conditional block
        var deep_skip = {
            if (true) {
                if (true) {
                    if (true) {
                        continue;
                        return 3;
                    }
                    return 4;
                }
                return 5;
            }
            return 6;
        }
        6 == deep_skip;                       // true

    // NOTE: Please don't ever do this either.

/// Loops
    
    // NOTE: There is no for loop in this language
    // NOTE: There is no break statement in this language

    // While loops are conditional blocks that will continue to run until the condition is false
        var _index = 0;
        while (_index < 5) {
            _index += 1;
        }
        5 == _index;                        // true

    // Block navigation rules remain unchanged;
        _index = 0;
        var _index_sum = 0;
        var while_value = while (true) {
            defer { _index += 1; }
            if (_index == 5) { return _index; }
            if (_index == 4) { return 9; }
            if (_index == 3) { continue; }
            _index_sum += _index;
        }
        9 == while_value;                   // true
        5 == _index;                        // true
        3 == _index_sum;                    // true

    // Slice logic can be used in a while loop
        var _slice_sum = 0;
        var _slice_index = 0;
        while (0~5) {
            defer { _slice_index += 1; }
            _slice_sum += _slice_index;
        }
        15 == _slice_sum;                 // true

/// Match statements

    // The final kind of conditional block
        var _match_value = 12;
        var _match_result = match (_match_value) {
            case (12): return 1;
            case (13): return 2;
            case (14): return 3;
            default: return 0;              // Match statements must be exhaustive
        }
        1 == _match_result;                 // true

    // Match statements continue following the same logic as other conditional blocks
        _match_value = 13;
        _match_result = match (_match_value) {
            case (12):
            case (13):
            case (14): return 1;
            default: return 0;
        }
        1 == _match_result;                 // true
    
    // Slice logic from tables can be used
        _match_result = match (_match_value) {
            case (12~14): return 3;
            default: return 0;
        }
        3 == match_result;                 // true

/// Types

    // NOTE: uint and sint translate to usize and isize in other languages. There is no current plan to support other sizes.
    // NOTE: This is not an embedded or systems language, and all u8 types would be stored as usize anyway.
    // NOTE: Types are not enforced by default, but can be declared to improve performance and readability
    // NOTE: The undefined keyword is not null, it simply means that the value will have whatever value was at the address it was allocated
    
    // Types are handled by default if not declared
        var _untyped_value = 12;
        #uint == std.Type.of(_untyped_value);   // true
    
    // As usage changes, so does the type
        _untyped_value -= 20;
        #sint == std.Type.of(_untyped_value);   // true

    // References are specially denoted with an @ prefix
        var reference => _untyped_value;
        @#sint == std.Type.of(reference);       // true

    // Types have types themselves
        var _type_type = std.Type.of(_untyped_value);
        #type == std.Type.of(_type_type);       // true

    // Declaring a type allows for faster execution as the value will be kept on the stack
        var _typed_value: #sint = 12;
        2 == _typed_value / 5;

    // All return values can be typed
    var typed_block: => #uint {
        var _typed_value = 12;
        return _typed_value;
    }

    // Functions can have their arguments typed
        var typed_function: (value: #uint) => #uint {
            return value + 1;
        }
        13 == run typed_function (12);      // true

    // Match statements intuit type only if type has been declared
        var typed_match_result = match (_typed_value) {
            case (0): return 0;
            case (1~): return 1;
            // No default case is required because match is exhaustive
        }
        1 == typed_match_result;            // true

    // In addition, the interpreter will make assumptions with static types
        // _typed_value = 3.14;      // ERROR: Expected [number, ;] found [.];
        // _typed_value = "Hello";   // ERROR: Expected [number, ;] found ["];

    // Typed values can be cast manually to other types
        std.Type.cast(@_typed_value, #uint);
    
    // Or it can be done implicitly
        _typed_value: #float;
        _typed_value = 3.14;
    
    // Casting to a string will use the string representation of the value
        _typed_value: @#string;
        "3.14" == _typed_value;
    
    // Casting to a boolean will return true if the value is not 0 or empty eg: "", []
        _typed_value = "";
        _typed_value: #boolean;
        false == _typed_value;
    
    // Values can also be quickly assigned using the undefined keyword
        var _undefined_value: #uint = undefined;

    // Values are not null, simply assigned from memory without being defined first and inheriting the value at that address
        12 == _undefined_value;   // could be true or false

    // The undefined keyword cannot be used if a type is not provided.
        // var _another_untyped_value = undefined;   // ERROR: Undefined is not null

    // Check whether a type is static or dynamic
        false == std.Type.is_static(_untyped_value);    // true
        true  == std.Type.is_static(_typed_value);      // true

    // Untyped values can be later coerced into a static type
        std.Type.cast(_untyped_value, std.Type.of(_untyped_value));
        true == std.Type.is_static(_untyped_value);     // true
    
    // Alternatively, this can also be shorthanded
        _untyped_value: std.Type.of(_untyped_value);    // WARNING: This value is already a #uint

/// User Types

    // User created types must start with a # symbol and are a table of some sort
        var #User_Value: [
            _value: #uint
        ];

    // This can then be used
        var user_typed_value: #User_Value = [
            _value = 12
        ];

    // Rules for user types are the same as other types
        // var incorrect_type: #User_Value = [ _value = "Hello" ];   // ERROR: Attempting to assign a string to an unsigned integer
        // var incorrect_type: #User_Value = [ _vale  = 12 ];        // ERROR: "_vale" is not a valid field for the type #User_Value

    // And the same assumptions are made by the interpreter while running
        // user_typed_value = 3.14;    // ERROR: Expected [number, ;] found [.];
        // user_typed_value = "Hello"; // ERROR: Expected [number, ;] found ["];

    // User types can be nested
        var #Nested_User_Value: [
            _value: #User_Value
        ];
        var nested_user_typed_value: #Nested_User_Value = [
            _value = user_typed_value
        ];
    
    // Because everything is done at run time, Generics are trivial and follow the same rules as functions for passing in arguments
        var #Generic_Type: (Type) [
            _value: Type
        ];
    
    // To use a generic type, simply pass in a type
        var generic_value: #Generic_User_Value(#uint) = [
            _value = 12;
        ];
    
    // Runtime evaluations of types are allowed as well
        var runtime_value: #Generic_User_Value(std.Type.of(user_typed_value)) = [
            _value = user_typed_value;
        ];

    // To declare a keyless table as a type, the following syntax is used
        var #Annoying_Fixed_Array: [#uint, #uint, #uint, #uint, #uint];
        var annoying_fixed_array: #Annoying_Fixed_Array = [0, 1, 2, 3, 4];

    // Alternatively we can use the range operator
        var #Fixed_Array: [#uint ~ 5];
        var fixed_array: #Fixed_Array = undefined;

    // Types can also be mixed
        var #Mixed_Array: [#float ~ 2, #uint ~ 3];
        var mixed_array: #Mixed_Array = [0.0, 1.0, 2, 3, 4];

/// Enums

    // Enums similar to Types, but are prefixed with ? instead
        var ?Pseudo_Bool: [
            True,
            False
        ];
    
    // Enums are declared as follows
        var true_enum: ?Pseudo_Bool = ?Pseudo_Bool.True;
    
    // Keep in mind all indexing options are valid for enums
        var false_enum: ?Pseudo_Bool = ?Pseudo_Bool[1];
    
    // Enums can be used in match statements
        var enum_match_result = match (true_enum) {
            case (?Pseudo_Bool.True): return 1;
            case (?Pseudo_Bool.False): return 2;
            // No default case is required because match can be guaranteed to be exhaustive
        }
        1 == enum_match_result;             // true
    
    // Enums operate similar to Rust in that this is valid;
        var ?Option: (Type) [
            Some: Type,
            None
        ];
    
    // To use this we can do the following
        var some_value: ?Option(#uint) = ?Option.Some(12);
        var none_value: ?Option(#uint) = ?Option.None;

        var unwrapped_value = match (some_value) {
            case (?Option.Some(value)): return value;
            case (?Option.None): return 0;
        }
        12 == unwrapped_value;               // true

        var default_value = match (none_value) {
            case (?Option.Some(value)): return value;
            case (?Option.None): return 0;
        }
    
/// Error handling