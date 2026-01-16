# Gasket

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Status: Early Development](https://img.shields.io/badge/Status-Early%20Development-orange)

> A functional boundary between Google Apps Script and the real world.

## Vision

**Gasket** is a small, opinionated functional library for **Google Apps Script**, written in **PureScript** and compiled to JavaScript.

Its purpose is to provide a *clean, typed, and principled boundary* between:

- the **imperative, dynamically-typed GAS runtime**, and
- a **pure, strongly-typed functional core**.

Gasket is not a framework, not a DSL, and not a full PureScript runtime for GAS.  
It is a **thin gasket**: a minimal layer that isolates effects, models domain logic with real ADTs, and keeps Google Apps Script manageable as projects grow.

---

## Design Goals

- **Strong type inference**  
  Leverage PureScript’s type system to model domain logic precisely, even when the host runtime is untyped.

- **Real ADTs, not conventions**  
  Use sum and product types to represent states, errors, and APIs explicitly.

- **Functional APIs for GAS services**  
  Sheets, Drive, Triggers, etc. exposed as typed, composable interfaces — not raw wrappers.

- **Explicit effect boundaries**  
  Side effects live at the edges. The core stays pure and testable.

- **Reasonable developer experience**  
  Clear module structure, predictable naming, minimal cognitive overhead.

---

## Non-Goals

Gasket is intentionally **not**:

- A complete replacement for the PureScript standard library
- A port of Haskell abstractions “for completeness”
- A macro-heavy or type-level playground
- A framework that hides Google Apps Script behavior
- A general-purpose JavaScript FP library

If something does not clearly improve **correctness**, **clarity**, or **maintainability** under GAS constraints, it does not belong here.

---

## Philosophy

Google Apps Script is an *effectful, stateful, and global* environment.

Gasket embraces this reality by:

- isolating impurity instead of pretending it does not exist
- modeling failures and edge cases explicitly
- favoring simple, law-abiding abstractions over clever ones
- keeping the FFI surface small, explicit, and auditable

The goal is not to make GAS “pure”, but to make it **predictable**.

---

## Architecture at a Glance

```text
Pure Domain Logic
        ▲
        │
   Gasket Core
        │
        ▼
 Explicit FFI Boundary
        │
        ▼
Google Apps Script Runtime
```

- **Core**: pure functions, ADTs, small foundational types  
- **Effect layer**: controlled interaction with the GAS runtime  
- **GAS modules**: typed facades over Sheets, Drive, etc.

---

## Intended Audience

Gasket is for developers who:

- are comfortable with functional programming concepts
- want strong guarantees in Apps Script projects
- prefer explicitness over magic
- value long-term maintainability over quick hacks

---

## Status

Early-stage and intentionally minimal.

APIs will evolve, but breaking changes will favor **simplification**, not feature accumulation.

---

## License

MIT © 2026 Adrián Donaldo Guevara Salomón
