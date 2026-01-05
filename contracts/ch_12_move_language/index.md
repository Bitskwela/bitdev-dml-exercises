---
title: "Course 12: Move Language"
description: "Move Language Smart Contract Development"

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2026-01-05"

# For SEO purposes
tags:
  ["markdown", "metadata", "bitskwela", "move", "sui", "aptos", "blockchain"]

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "course-12-move-language"

# Can be the same as permaname but can be changed if needed.
slug: "course-12-move-language"
---

# Prologue: Welcome to Your Move Language Journey 🚀

Welcome, future blockchain developer! You're about to embark on an exciting journey that will transform you from a complete beginner into a confident Move smart contract developer. This course is designed with one mission in mind: **taking you from zero to hero** in the world of next-generation blockchain development.

## What Awaits You

In this comprehensive 50-lesson course, you'll master the Move programming language—the smart contract language powering next-generation blockchains like Sui, Aptos, and Movement Labs. Every lesson comes with hands-on exercises that build upon each other, creating a solid foundation for your blockchain development career.

### Our Resource-First Approach

Throughout this course, you'll learn Move's unique resource-oriented programming model. Resources aren't just an afterthought—they're Move's superpower that prevents common bugs like double-spending and asset loss. You'll discover how to:

- Write secure smart contracts with Move's ownership model
- Use the abilities system (copy, drop, store, key) to control data behavior
- Leverage generics and advanced type patterns
- Test your contracts with Move's built-in testing framework
- Build chain-agnostic code that works on any Move platform

### Your Learning Path

This course is structured as a series of challenges and lessons that mirror real-world blockchain development scenarios. Each lesson includes:

- **Theory**: Core concepts explained in simple, practical terms
- **Practice**: Hands-on coding exercises with smart contracts
- **Real-world context**: Understanding when and why to use each concept

## Course Overview

This course follows the MoveStack team—a group of Filipino developers building a chain-agnostic toolkit that works across any Move-based blockchain. Through their journey, you'll learn Move fundamentals, ownership semantics, advanced patterns, and production-ready security practices.

## Learning Path

### Arc 1: Foundations (Lessons 01-10)

Build your Move foundation from the ground up.

| Lesson | Title                                                    | Topics                         |
| ------ | -------------------------------------------------------- | ------------------------------ |
| 01     | [Introduction to Move](le_01_intro_to_move/mat_1.md)     | What is Move, first module     |
| 02     | [Modules and Scripts](le_02_spell_books/mat_1.md)        | Module structure, organization |
| 03     | [Primitive Types](le_03_every_variable_matters/mat_1.md) | u8-u256, bool, address, vector |
| 04     | [Functions](le_04_functions_deep_dive/mat_1.md)          | Function syntax, visibility    |
| 05     | [Structs](le_05_data_modelling/mat_1.md)                 | Data modeling, fields          |
| 06     | [Abilities](le_06_abilities/mat_1.md)                    | copy, drop, store, key         |
| 07     | [Resources](le_07_resources/mat_1.md)                    | Resource-oriented programming  |
| 08     | [Global Storage](le_08_global_storage/mat_1.md)          | move_to, borrow_global         |
| 09     | [Constants](le_09_constants_addresses/mat_1.md)          | Constants, named addresses     |
| 10     | [Documentation](le_10_documentation/mat_1.md)            | Comments, doc strings          |

### Arc 2: Ownership & References (Lessons 11-16)

Master Move's unique ownership model.

| Lesson | Title                                                     | Topics                 |
| ------ | --------------------------------------------------------- | ---------------------- |
| 11     | [Ownership Semantics](le_11_ownership_semantics/mat_1.md) | Move vs copy           |
| 12     | [References](le_12_references_borrowing/mat_1.md)         | Borrowing, &T          |
| 13     | [Mutable References](le_13_mutable_references/mat_1.md)   | &mut T, modification   |
| 14     | [Reference Safety](le_14_reference_safety/mat_1.md)       | Borrow checker rules   |
| 15     | [Acquires](le_15_acquires/mat_1.md)                       | acquires annotation    |
| 16     | [Phantom Types](le_16_phantom_types/mat_1.md)             | Type-level programming |

### Arc 3: Control Flow & Logic (Lessons 17-22)

Implement business logic with confidence.

| Lesson | Title                                               | Topics              |
| ------ | --------------------------------------------------- | ------------------- |
| 17     | [Conditionals](le_17_conditionals/mat_1.md)         | if/else expressions |
| 18     | [Loops](le_18_loops/mat_1.md)                       | while, loop, break  |
| 19     | [Pattern Matching](le_19_pattern_matching/mat_1.md) | Destructuring       |
| 20     | [Abort and Assert](le_20_abort_assert/mat_1.md)     | Error handling      |
| 21     | [Option Type](le_21_option_type/mat_1.md)           | std::option         |
| 22     | [Vectors](le_22_vectors/mat_1.md)                   | std::vector         |

### Arc 4: Collections & Data Structures (Lessons 23-28)

Work with complex data.

| Lesson | Title                                                     | Topics                 |
| ------ | --------------------------------------------------------- | ---------------------- |
| 23     | [Vector Fundamentals](le_23_vector_fundamentals/mat_1.md) | Creation, manipulation |
| 24     | [Vector Operations](le_24_vector_operations/mat_1.md)     | Advanced patterns      |
| 25     | [Tables](le_25_tables/mat_1.md)                           | Key-value storage      |
| 26     | [Linked Structures](le_26_linked_structures/mat_1.md)     | Ordered data           |
| 27     | [Sets and Maps](le_27_sets_maps/mat_1.md)                 | VecSet, VecMap         |
| 28     | [Nested Collections](le_28_nested_collections/mat_1.md)   | Complex hierarchies    |

### Arc 5: Modularity & Architecture (Lessons 29-34)

Organize production codebases.

| Lesson | Title                                                   | Topics                   |
| ------ | ------------------------------------------------------- | ------------------------ |
| 29     | [Module Visibility](le_29_module_visibility/mat_1.md)   | public, private, friend  |
| 30     | [Friend Modules](le_30_friend_modules/mat_1.md)         | Controlled access        |
| 31     | [Entry Functions](le_31_entry_functions/mat_1.md)       | Transaction entry points |
| 32     | [Multi-Module](le_32_multi_module/mat_1.md)             | Project organization     |
| 33     | [Package Management](le_33_package_management/mat_1.md) | Move.toml                |
| 34     | [Dependencies](le_34_dependency_management/mat_1.md)    | External packages        |

### Arc 6: Advanced Type System (Lessons 35-40)

Master generics and patterns.

| Lesson | Title                                                     | Topics                  |
| ------ | --------------------------------------------------------- | ----------------------- |
| 35     | [Generics](le_35_generics/mat_1.md)                       | Type parameters         |
| 36     | [Generic Constraints](le_36_generic_constraints/mat_1.md) | Ability constraints     |
| 37     | [Phantom Parameters](le_37_phantom_parameters/mat_1.md)   | Type-level markers      |
| 38     | [Type Inference](le_38_type_inference/mat_1.md)           | Compiler inference      |
| 39     | [Witness Pattern](le_39_witness_pattern/mat_1.md)         | One-time initialization |
| 40     | [Capability Pattern](le_40_capability_pattern/mat_1.md)   | Permission tokens       |

### Arc 7: Testing & Quality (Lessons 41-44)

Write reliable, tested code.

| Lesson | Title                                                     | Topics              |
| ------ | --------------------------------------------------------- | ------------------- |
| 41     | [Unit Testing](le_41_unit_testing/mat_1.md)               | #[test], assertions |
| 42     | [Test Fixtures](le_42_test_fixtures/mat_1.md)             | Helpers, setup      |
| 43     | [Integration Testing](le_43_integration_testing/mat_1.md) | Multi-module tests  |
| 44     | [Property Testing](le_44_property_testing/mat_1.md)       | Invariants          |

### Arc 8: Events & State (Lessons 45-48)

Build production features.

| Lesson | Title                                           | Topics                 |
| ------ | ----------------------------------------------- | ---------------------- |
| 45     | [Events](le_45_events/mat_1.md)                 | Event emission         |
| 46     | [State Machines](le_46_state_machines/mat_1.md) | Workflow modeling      |
| 47     | [Upgradability](le_47_upgradability/mat_1.md)   | Version patterns       |
| 48     | [Access Control](le_48_access_control/mat_1.md) | Role-based permissions |

### Arc 9: Optimization & Security (Lessons 49-50)

Ship secure, efficient code.

| Lesson | Title                                                 | Topics                        |
| ------ | ----------------------------------------------------- | ----------------------------- |
| 49     | [Gas Optimization](le_49_gas_optimization/mat_1.md)   | Efficiency techniques         |
| 50     | [Security Capstone](le_50_security_capstone/mat_1.md) | Best practices, final project |

## Characters

Meet the MoveStack team:

- **Det** - Senior Engineer (patient mentor)
- **Ronnie** - Architect (system design expert)
- **Liway** - Community Manager (real-world feedback)
- **Odessa** - Security Lead (finds edge cases)
- **Neri** - Lead Developer (protagonist, learns through the course)
- **Loy** - DevOps (deployment and infrastructure)
- **EJ** - Testing Lead (quality obsessed)
- **Salvo** - Performance Engineer (optimization expert)
- **Dex** - Protocol Specialist (deep blockchain knowledge)
- **Jaymart** - Junior Developer (asks great questions)
- **Joas** - Backend Developer (integration specialist)
- **Mike** - Product Manager (user perspective)
- **Lenard** - Documentation Lead (clear communication)

## Chain-Agnostic Philosophy

This course teaches Move fundamentals that work on **any Move-based blockchain**:

- Sui Network
- Aptos
- Movement Labs
- Future Move platforms

All code uses standard library imports (`std::`) and avoids ecosystem-specific patterns. Where platforms differ, we provide ecosystem notes without favoring any chain.

## Prerequisites

- Basic programming experience in any language
- Understanding of blockchain concepts (helpful but not required)
- No prior Move or Rust experience needed

## Ready to Begin?

Whether you're a complete programming beginner or an experienced developer new to Move, this course will meet you where you are and guide you to where you want to be. By the end of this journey, you'll have the confidence and skills to build, test, and deploy professional-grade Move smart contracts.

Let's begin your transformation into a Move hero! 🦸‍♂️

---

_Built with ❤️ by the Bitskwela team_
