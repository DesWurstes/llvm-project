//===-- Implementation header for lsearch -----------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_SEARCH_LSEARCH_H
#define LLVM_LIBC_SRC_SEARCH_LSEARCH_H

#include "src/__support/macros/config.h"
#include <stddef.h> // size_t

namespace LIBC_NAMESPACE_DECL {
void *lsearch(const void *key, void *base, size_t *nmemb, size_t size,
              int (*compar)(const void *, const void *));
} // namespace LIBC_NAMESPACE_DECL

#endif // LLVM_LIBC_SRC_SEARCH_LSEARCH_H
