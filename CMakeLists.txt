cmake_minimum_required(VERSION 2.8)
find_package(Java REQUIRED)
include(UseJava)

project(hello-wikipedia)
file(GLOB sources *.java)
add_jar(hello-wikipedia ${sources})

