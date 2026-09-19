#include <iostream>

#include "encoding.hpp"

int main() {
    #ifdef __ARM_FEATURE_ 
        std::cout << "meow";
    #endif


    return 0;
}