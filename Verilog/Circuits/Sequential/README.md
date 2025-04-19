# Sequential Logic

!!! Review LnFF from 14 to 18 again!

## 1. Latches and Flip-Flops
### JK -> D
#### 1. JK 플립플롭의 동작 정의

JK 플립플롭의 truth table은 다음과 같습니다:

| J | K | Q(next) | 설명         |
|---|---|----------|--------------|
| 0 | 0 | Q        | 유지 (no change) |
| 0 | 1 | 0        | 리셋         |
| 1 | 0 | 1        | 셋           |
| 1 | 1 | ~Q       | 토글         |

#### 목표:  
이 동작을 만족하는 **D 입력식을** 구하고자 합니다.


#### 2. D 플립플롭의 특징

- D 플립플롭은 단순히 **다음 상태를 D 입력으로 받아서 저장**합니다.
- 즉, `Q_next = D`

따라서 JK 플립플롭의 `Q_next`를 표현하는 논리식을 D로 바꾸면 됩니다.

#### 3. 상태식 세우기

우선 `Qold`를 현재 상태라고 두고, `Q_next`를 JK truth table에 맞춰 표현합니다.

| J | K | Qold | Q_next (D) |
|---|---|------|------------|
| 0 | 0 | 0    | 0          |
| 0 | 0 | 1    | 1          |
| 0 | 1 | 0    | 0          |
| 0 | 1 | 1    | 0          |
| 1 | 0 | 0    | 1          |
| 1 | 0 | 1    | 1          |
| 1 | 1 | 0    | 1          |
| 1 | 1 | 1    | 0          |

이 truth table을 기반으로 **D를 J, K, Qold의 조합으로 표현**합니다.

#### 4. 논리식 유도 (카르노 맵 기반 또는 식 단순화)

D = (J & ~Qold) | (~K & Qold)

#### 풀이 요약:
- J=1, K=0이면 → D=1 (Set)
- J=0, K=1이면 → D=0 (Reset)
- J=1, K=1이면 → D = ~Qold (Toggle)
- J=0, K=0이면 → D = Qold (Hold)

#### 이 모든 조건을 만족하는 식이 바로:

> **D = (J & ~Q) | (~K & Q)**

#### 최종 결과

```verilog
D = (J & ~Q) | (~K & Q)
```

## 2. Counter

Ex. 5 ~ 8 Review. BCD Counting 주의