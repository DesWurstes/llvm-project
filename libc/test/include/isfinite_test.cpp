//===-- Unittest for isfinite[d] macro ------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "IsFiniteTest.h"
#include "include/llvm-libc-macros/math-function-macros.h"

LIST_ISFINITE_TESTS(double, isfinite)
