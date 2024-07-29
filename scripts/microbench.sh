#!/bin/bash
# (C) 2021 lcpc authors

set -e

DATE=$(date +%Y%m%d)
CPUS=$(sysctl -n hw.ncpu)

# cleanup
cargo clean

# ligero tests
( 
	cd lcpc-ligero-pc
#	cargo +nightly test --release --features isz rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_isz.txt
#	cargo +nightly test --release --features hlf rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_hlf.txt
	RUSTFLAGS="-A warnings" cargo +nightly test --release rough_bench -- --ignored --nocapture 2>&1 | grep -v "Compiling" | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_dfl.txt

#	cargo +nightly test --release --features isz prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_isz_pvs.txt
#	cargo +nightly test --release --features hlf prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_hlf_pvs.txt
	RUSTFLAGS="-A warnings" cargo +nightly test --release prove_verify_size_bench -- --ignored --nocapture 2>&1 | grep -v "Compiling" | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_ligero_dfl_pvs.txt

#	RAYON_NUM_THREADS=1 cargo test --release --features isz rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_isz.txt
#	RAYON_NUM_THREADS=1 cargo test --release --features hlf rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_hlf.txt
#	RAYON_NUM_THREADS=1 cargo test --release rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_dfl.txt
#
#	RAYON_NUM_THREADS=1 cargo test --release --features isz prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_isz_pvs.txt
#	RAYON_NUM_THREADS=1 cargo test --release --features hlf prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_hlf_pvs.txt
#	RAYON_NUM_THREADS=1 cargo test --release prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_ligero_dfl_pvs.txt
)

# brakedown tests
(
  cd lcpc-brakedown-pc
	RUSTFLAGS="-A warnings" cargo +nightly test --release rough_bench -- --ignored --nocapture 2>&1 | grep -v "Compiling" | tee ../doc/benchmark-results/${DATE}_${CPUS}c_brakedown_dfl.txt
	RUSTFLAGS="-A warnings" cargo +nightly test --release prove_verify_size_bench -- --ignored --nocapture 2>&1 | grep -v "Compiling" | tee ../doc/benchmark-results/${DATE}_${CPUS}c_brakedown_dfl_pvs.txt
)

# sdig tests
#(
#	cd sdig-pc
#	cargo test --release rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_sdig.txt
#	cargo test --release prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_${CPUS}c_255bit_sdig_pvs.txt
#
#	RAYON_NUM_THREADS=1 cargo test --release rough_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_sdig.txt
#	RAYON_NUM_THREADS=1 cargo test --release prove_verify_size_bench -- --ignored --nocapture 2>&1 | tee ../doc/benchmark-results/${DATE}_1c_255bit_sdig_pvs.txt
#)
