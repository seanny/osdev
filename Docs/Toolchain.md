# Toolchain

The project uses a freestanding GNU cross-toolchain for 64-bit Arm. The build
scripts compile Binutils and GCC for the `aarch64-none-elf` target and install
them under `out/` in the project root.

The commands below may be run from any working directory because each script
locates the project root automatically.

## Prerequisites

Building the toolchain requires:

- Bash
- `make`
- A native C and C++ compiler
- `tar` with XZ support
- `curl` or `wget`
- `sha256sum` or `shasum`
- The GMP, MPFR and MPC development libraries required by GCC

On macOS, install the Xcode Command Line Tools to provide the native compiler
and build tools. The remaining libraries can be installed with a package
manager such as Homebrew. On Linux, install the equivalent development
packages using the distribution's package manager.

The build needs several gigabytes of free disk space and may take a while,
particularly when compiling GCC.

## Build

Run the following commands from the project root:

```sh
./Scripts/Download.sh
./Scripts/Extract.sh
./Scripts/Arm64.sh
```

The scripts perform these stages:

1. `Download.sh` downloads the pinned Binutils and GCC source archives into
   `release/`. It then verifies both archives against `Scripts/SHA256SUMS`.
2. `Extract.sh` extracts the verified archives into `src/`.
3. `Arm64.sh` builds Binutils followed by a freestanding C-only GCC and
   installs the finished toolchain into `out/`.

The build runs in parallel using the number of logical CPUs reported by the
host system. Intermediate files are placed under
`build/aarch64-none-elf/`.

## Verify the installation

After the build completes, check that the cross-compiler and assembler run:

```sh
./out/bin/aarch64-none-elf-gcc --version
./out/bin/aarch64-none-elf-as --version
```

To use the tools directly in the current shell, add their directory to
`PATH`:

```sh
export PATH="$(pwd)/out/bin:$PATH"
```

This `PATH` change lasts only for the current shell session.

## Rebuilding

Running `Arm64.sh` again removes and recreates the Binutils and GCC
intermediate build directories. Downloaded archives, extracted sources and
installed files are retained.

To retry a failed or interrupted download, remove the incomplete archive from
`release/` before running `Download.sh` again. Existing archives are not
downloaded again, but their checksums are still verified.

## Updating the toolchain versions

Toolchain versions are pinned in `Scripts/Versions.sh`. When changing a
version, also update the corresponding filename and SHA-256 digest in
`Scripts/SHA256SUMS`. Then download and extract the new sources before
rebuilding.

Checksums should be obtained from a trusted upstream source and verified
before committing the update.

## Troubleshooting

### Checksum verification fails

The archive may be incomplete, corrupted or inconsistent with the pinned
version. Remove the named file from `release/` and run `Download.sh` again. Do
not build from an archive that fails verification.

### GCC reports missing GMP, MPFR or MPC

Install the development packages for the missing libraries, then rerun
`Arm64.sh`. Package names vary between operating systems and Linux
distributions.

### A build command is missing

Confirm that the prerequisites are installed and available through `PATH`.
On macOS, running `xcode-select --install` installs the standard compiler and
command-line build tools.
