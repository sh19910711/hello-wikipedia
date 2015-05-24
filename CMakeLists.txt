cmake_minimum_required(VERSION 2.8)

find_package(Java REQUIRED)
include(UseJava)

project(hello-wikipedia)
file(GLOB rank_sources rank/*.java)
add_jar(rank ${rank_sources})

