#include <iostream>

#include "foo.hpp"

using namespace std;

int main(int argc, char *argv[])
{
    cout << "Hallo Welt!" << endl; 
    foo::print_foo();

    return 0; 
}
