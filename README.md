# CPU Race

https://etherdream.github.io/cpu-race

Measure your CPU's clock speed online and compete on the leaderboard.

The test runs a fixed amount of work in your browser, and the server measures how long the challenge takes. From the known workload and elapsed time, it estimates your CPU's clock speed.

Think you can beat the test? Try finding a flaw in the algorithm or using custom hardware to get a better score.


## The algorithm

`a` and `b` are the challenge values issued by the server, and `n` is the number of iterations. The resulting state is your answer, which you submit to the server for verification.

```cpp
while (n--) {
    a = rotl((a ^ b) * 0xD1342543DE82EF95, 17);
    b = rotl((b ^ a) * 0x4B33A62ED433D4A3, 19);

    a = rotl((a ^ b) * 0x9E68D429265516D3, 21);
    b = rotl((b ^ a) * 0x2D358DCCAA6C78A5, 23);

    a = rotl((a ^ b) * 0xC6A4A7935BD1E995, 25);
    b = rotl((b ^ a) * 0xCB24D0A5C88C35B3, 27);

    a = rotl((a ^ b) * 0x27D4EB2F165667C5, 29);
    b = rotl((b ^ a) * 0x5851F42D4C957F2D, 31);
}
```

Full demo: [mrx.cpp](algo/mrx.cpp)

It resembles the ARX (Add–Rotate–Xor) construction used in cryptography, but replaces addition with multiplication — hence MRX.

Each iteration depends on the previous state, so the computation is serial, with no obvious way to parallelize it within a challenge. Only single-core speed matters.

WebAssembly adds very little overhead for this algorithm. Even a native build is unlikely to be much faster. Try building the demo above locally and comparing its performance with the web page.

> Why not a VDF? VDFs are complex to implement and perform poorly in WebAssembly. A native program could also exploit CPU-specific instructions, widening the gap further.

## Server-side verification

Unlike typical proof-of-work systems, where solving is expensive but verification is cheap, this algorithm is costly both to compute and to verify.

We therefore precompute a large pool of challenge–answer pairs offline. When a challenge is issued, the server looks up its answer instead of computing it on the spot.

The pool is refreshed periodically to make large-scale scraping harder.

## Timing

The server measures the runtime:

```js
duration = answer_received_timestamp - question_sent_timestamp
```

That interval includes network latency in both directions, browser overhead, and the computation itself. Network latency and browser overhead don't reflect CPU speed, so a longer run reduces their share of the total time.

The iteration count `n` is currently 2.5 billion. At roughly 40 cycles per iteration, a run takes about 100 billion cycles — around 20 seconds at 5 GHz.


## Breaking it

Besides overclocking a high-end CPU, you could try:

* Finding a shortcut in the algorithm (can you skip iterations or compute the final state faster?).

* Scraping challenges to build a lookup table (possible in principle, but impractical given the pool size and request rate limits).

* Using a lower-latency connection (latency is only a small part of the total time, so the gain is limited).

* Trying an FPGA (it may not offer a latency advantage, since FPGAs typically run at much lower clock frequencies than CPUs).

* Building an ASIC (potentially a few times faster, but extremely expensive).

## Other uses

* Browser-based proof of work designed to resist parallel and native-code acceleration.

* [Browser-based time lock](https://github.com/EtherDream/timelock) — the sender encrypts a message that nobody can open until a specified amount of time has passed.
