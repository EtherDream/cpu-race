(module
  ;; [a, b] = instance.exports.solve(a, b, n)     // 0 < n < 2^32
  (func $solve (export "solve")
    (param $a i64) (param $b i64) (param $n i32)
    (result i64 i64)
    (loop $iter
      (local.set $a (i64.rotl (i64.mul (i64.xor (local.get $a) (local.get $b)) (i64.const 0xD1342543DE82EF95)) (i64.const 17)))
      (local.set $b (i64.rotl (i64.mul (i64.xor (local.get $b) (local.get $a)) (i64.const 0x4B33A62ED433D4A3)) (i64.const 19)))

      (local.set $a (i64.rotl (i64.mul (i64.xor (local.get $a) (local.get $b)) (i64.const 0x9E68D429265516D3)) (i64.const 21)))
      (local.set $b (i64.rotl (i64.mul (i64.xor (local.get $b) (local.get $a)) (i64.const 0x2D358DCCAA6C78A5)) (i64.const 23)))

      (local.set $a (i64.rotl (i64.mul (i64.xor (local.get $a) (local.get $b)) (i64.const 0xC6A4A7935BD1E995)) (i64.const 25)))
      (local.set $b (i64.rotl (i64.mul (i64.xor (local.get $b) (local.get $a)) (i64.const 0xCB24D0A5C88C35B3)) (i64.const 27)))

      (local.set $a (i64.rotl (i64.mul (i64.xor (local.get $a) (local.get $b)) (i64.const 0x27D4EB2F165667C5)) (i64.const 29)))
      (local.set $b (i64.rotl (i64.mul (i64.xor (local.get $b) (local.get $a)) (i64.const 0x5851F42D4C957F2D)) (i64.const 31)))

      (br_if $iter (local.tee $n (i32.sub (local.get $n) (i32.const 1))))
    )
    (local.get $a)
    (local.get $b)
  )
)
