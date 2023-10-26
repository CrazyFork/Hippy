/*
 * Tencent is pleased to support the open source community by making
 * Hippy available.
 *
 * Copyright (C) 2022 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

// Calculate size of array
#define ARRAY_SIZE(array) (sizeof(ARRAY_SIZE_HELPER(array)))
//

template <typename T>
constexpr inline size_t SIZE_OF = sizeof(T);

// https://www.geeksforgeeks.org/how-to-find-size-of-array-in-cpp-without-using-sizeof-operator/
// see No.4

// m:cpp, reinterpret this array using type of char
// so sizeof would return this array size in type of char
template <typename CharType, size_t N>
char (&ARRAY_SIZE_HELPER(CharType (&array)[N]))[N];
//                                  ^ reference to CharType[N]
//    ^ reference to char[N]


#define WEAK_THIS weak_this = weak_from_this()
#define SHARED_THIS self = this->shared_from_this()
// 表明该lambda不会被存储，可以安全使用this
#define THIS_NO_STORE this

// tell if weak_this has value ?
#define HAS_SELF(type) auto self = std::static_pointer_cast<type>(weak_this.lock())
//                                  ^ would return nullpointer if weak_this has no value

#define DEFINE_SELF(type) HAS_SELF(type);
// it
#define DEFINE_AND_CHECK_SELF(type) \
  DEFINE_SELF(type)                 \
  if (!self) {                      \
    return;                         \
  }


