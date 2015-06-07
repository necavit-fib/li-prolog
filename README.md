# LI Prolog exercices

This repository holds a series of exercices and problems solved using Prolog,
for the Logic in Informatics (LI) course. The repository is structured in the
following directories:

* `basic` - contains simple, initiatory exercices to learn the basics of the Prolog
language. **Corresponds to the 2nd assignment.**
* `problems` - more complex problems, some of which use a common optimization scheme.
**Corresponds to the 4th assignment.**

## Basic problems

A script named `supercharged-prolog.sh` is provided to fire up a SWI-Prolog engine
already loaded with the definitions and predicates of the basic exercices, contained
in the `exercices.pl` file.

## Problems

There are 4 different problems solvers inside this directory, namely `bridge`,
`buckets`, `cachan` and `cannibals`.

**Please note!** that neither problem solver can be used without the additional
runner script provided in the root folder, named `run.sh`. Some necessary code
is injected by the script (assertions and generic predicates) and, therefore,
compiling the solvers without the script will render them non-functional.

#### The script

The `run.sh` script has a usage help available (execute `./run.sh --help`to
see it) and can be used as follows:

* For the `bridge`, `buckets` and `cannibals` problems, the solvers can be run as:

```bash
./run.sh PROBLEM_NAME
```

This will compile the solver using the generic predicates defined in the
`generic-solver.pl` file and the problem dedicated logic, inside each of the
subdirectories (one per problem). Once compiled, the solver is automatically executed.

* The `cachan` problem can be executed as:

```bash
./run.sh cachan [--check]
```

Similarly to the rest of problems, the solver is compiled and executed. The
`--check` flag enables solution checking (the compiled executable is different).
