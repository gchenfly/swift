// RUN: %empty-directory(%t)
// RUN: echo 'print("Hello, World!")' >%t/main.swift
// RUN: touch %t/𝔼-file-01.swift %t/😂-file-02.swift %t/Ω-file-03.swift
//
// If the supplementary output file map does not escape the characters in the
// source files, the frontend won't recognize the desired outputs.
//
// RUN: (cd %t && %target-build-swift -c -save-temps -emit-dependencies -emit-loaded-module-trace -emit-loaded-module-trace-path %t/lmt -serialize-diagnostics -driver-use-filelists -j2 main.swift  𝔼-file-01.swift 😂-file-02.swift Ω-file-03.swift  -module-name mod)
// RUN: (cd %t && test -e 😂-file-02.d -a -e 😂-file-02.dia -a -e 😂-file-02.o -a -e 😂-file-02.swift -a -e 𝔼-file-01.d -a -e 𝔼-file-01.dia -a -e 𝔼-file-01.o -a -e 𝔼-file-01.swift -a -e main.d -a -e main.dia -a -e Ω-file-03.d -a -e Ω-file-03.dia -a -e Ω-file-03.o -a -e Ω-file-03.swift)
