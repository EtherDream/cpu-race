// make native && ./mrx
#include <cstdint>
#include <chrono>
#include <print>
#include <bit>

using namespace std::chrono_literals;
using std::chrono::steady_clock;
using std::println;
using std::rotl;


inline void solve(uint64_t &a, uint64_t &b, uint64_t n) {
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
}

int main() {
    uint64_t a = 12345, b = 67890;  // test
    uint64_t n = 2'500'000'000;
    println("running {} iterations...", n);

    auto t0 = steady_clock::now();
    solve(a, b, n);
    auto t1 = steady_clock::now();

    auto time = (t1 - t0) / 1ms;
    println("result: {},{} time: {} ms", a, b, time);
    return 0;
}