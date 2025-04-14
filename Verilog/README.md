# Verilog

Reviewing `verilog` referring to [HDLBits](https://hdlbits.01xz.net/wiki/Main_Page).

## 1. Basics

### Notes
- `assign` (continuous assignment) : assignment continues all the time even if the right side's value changes.

#### `wire` vs `reg`
| Feature            | wire                           | reg                              |
|--------------------|----------------------------------|-------------------------------------|
| Meaning            | Represents a physical wire       | Represents a storage element        |
| Value source       | Must be driven by another element (e.g., assign, gate output) | Holds value assigned in a procedural block (always, initial) |
| Usage              | For combinational logic connections | For sequential logic or variables in always blocks |
| Can be assigned in | assign statements only           | always, initial blocks only         |
| Cannot be used in  | always blocks                    | assign statements                   |



## 2. Vectors

### Vector Declaration
- **Syntax**: `type [upper:lower] name;`
- `type`: usually `wire` or `reg`, can include `input`, `output`.
- **Examples**:
  - `wire [7:0] w;` → 8-bit wire, little-endian.
  - `reg [4:1] x;` → 4-bit reg, big-endian.
  - `output reg [0:0] y;` → 1-bit reg output (still vector).
  - `input wire [3:-2] z;` → 6-bit input, negative index allowed.
  - `wire [0:7] b;` → 8-bit wire, but **big-endian** (`b[0]` is MSB).

---

### Endianness
- `[3:0]`: Little-endian (`[0]` = LSB).
- `[0:3]`: Big-endian (`[0]` = MSB).
- **Must be used consistently.** `vec[0:3]` is illegal if declared `vec[3:0]`.

---

### Implicit Nets
- Undeclared wires are auto-created as **1-bit** wires.
- Can cause **bugs** when vector was intended.
- Prevent with:  
  ```verilog
  `default_nettype none
  ```
  → Turns undeclared net into **compile error**.

---

### Packed vs. Unpacked Arrays
- **Packed**: Bit vector (`reg [7:0] data`)
- **Unpacked**: Array of bit vectors (`reg [7:0] mem [255:0]`)
- Useful for memory-like structures.

---

### Part-Select
- Access sub-parts of a vector: `vec[upper:lower]`
- Must match declared direction:
  - OK: `w[3:0]` (if declared `[7:0]`)
  - Illegal: `b[3:0]` (if declared `[0:7]`)
- Single bit: `x[1]` or `x[1:1]`
- Assignment with part-select:  
  ```verilog
  assign w[3:0] = b[0:3];  // b[0] → w[3], b[1] → w[2], ...
  ```

### Notes:
- `{num{vector}}` (concatenation operator)
  - {5{1'b1}} : 5'b11111
  - {2{a,b,c}} : {a,b,c,a,b,c}


## 3. Modules