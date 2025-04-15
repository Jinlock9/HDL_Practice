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

## 4. Procedures

### `assign` vs `always @(*)`

- Two ways to describe combinational logic:
  - `assign out = expr;` → Continuous assignment
  - `always @(*) out = expr;` → Procedural assignment

- **Both produce identical hardware** (combinational logic), but differ in **syntax and flexibility**:
  - `assign` → simpler, no `if`, `case`, etc.
  - `always @(*)` → supports rich control logic (`if`, `case`), useful for complex circuits

- **Use `@(*)`** (or `always_comb` in SystemVerilog) to ensure all inputs are included in the sensitivity list.
  - Manually listing inputs can cause **simulation mismatches** if a signal is omitted.

- **`wire` vs `reg`:**
  - `assign` → left-hand side must be `wire`
  - `always` → left-hand side must be `reg`
  - These are just **syntactic rules**, not related to actual synthesized hardware structure.

- **Note:** Procedural continuous assignments (`assign` inside `always`) exist but are not synthesizable.

### Clocked Always Blocks & Assignment Types in Verilog

#### **Two Types of Synthesizable `always` Blocks**

1. **Combinational Logic**  
   - `always @(*)`  
   - Models pure logic (no memory)
   - Outputs update **immediately** when inputs change

2. **Clocked Logic**  
   - `always @(posedge clk)`  
   - Models **sequential logic** (e.g., flip-flops/registers)
   - Output updates **on the rising edge** of the clock
   - Stores values between clock cycles

---

#### **Assignment Types in Verilog**

| Type                        | Syntax         | Context             | Meaning                                                                 |
|-----------------------------|----------------|----------------------|-------------------------------------------------------------------------|
| **Continuous**              | `assign x = y;`| Outside `always`     | Constantly drives `x` with `y`                                         |
| **Blocking (procedural)**   | `x = y;`       | Inside `always`      | Executes immediately (sequentially, like C)                            |
| **Non-blocking (procedural)**| `x <= y;`      | Inside `always`      | Scheduled for update at the end of the time step (parallel semantics)  |

---

#### Best Practices

- Use **blocking (`=`)** inside **combinational** `always @(*)` blocks  
- Use **non-blocking (`<=`)** inside **clocked** `always @(posedge clk)` blocks  
- Mixing these incorrectly causes **hard-to-debug simulation mismatches** and **synthesis issues**

> Understanding the simulator's event scheduling is not necessary for hardware design, but **following these rules is critical** for correct synthesis and simulation alignment.

### Summary: Avoiding Unintended Latches in Verilog

A common source of bugs in Verilog is unintentionally creating latches by writing incomplete combinational logic. Latches occur when an `always @(*)` block doesn't assign a value to an output under all conditions. In such cases, Verilog "remembers" the previous value using a latch.

**Incorrect example (creates latch):**
```verilog
always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1; // No assignment when condition is false
end
```

This causes Verilog to infer a latch, since it must preserve the previous value when the condition is false.

**Correct approach (avoids latch):**
```verilog
always @(*) begin
    shut_off_computer = 0;      // Default assignment
    if (cpu_overheated)
        shut_off_computer = 1;
end
```

**Key guidelines:**
- Always assign a value to every output in all code paths.
- Use default assignments at the beginning of `always @(*)` blocks.
- Include `else` clauses for all `if` conditions, or provide defaults beforehand.

**Takeaway:**
Think in terms of actual circuit structure first. Do not rely on writing code and hoping the synthesizer generates the desired logic. If you see messages like "inferring latch," review your code to ensure all outputs are assigned under all conditions.

Let me know if you'd like this in table form or want to review common latch-inducing patterns.
