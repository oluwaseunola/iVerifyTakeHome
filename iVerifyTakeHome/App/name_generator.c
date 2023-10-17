//
//  name_generator.c
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

#include <stdlib.h>
#include <string.h>

char* rand_name(char buff[], size_t size)
{
    const char abc[] = "abcdefghijklmnopqrstuvwxyz";
    const char vowels[] = "aeiouy";
    for (size_t i = 0; i < size; i++) {
        if (i % 2 == 1) {
            int abcSize = (int) (sizeof abc - 1);
            int key = (int) arc4random_uniform(abcSize);
            buff[i] = abc[key];
        } else {
            int vowelsSize = (int) (sizeof vowels - 1);
            int key = (int) arc4random_uniform(vowelsSize);
            buff[i] = vowels[key];
        }
    }
    buff[size] = '\\0';
    return buff;
}

char* get_name(void) {
    char buff[100];
    int firstNameSize = (int)arc4random_uniform(7) + 3;
    int secondNameSize = (int)arc4random_uniform(7) + 3;
    char* name = (char*)malloc(40 * sizeof(char));
    strcpy(name, rand_name(buff, firstNameSize));
    strcat(name, " ");
    strcat(name, rand_name(buff, secondNameSize)); 
    return name;
}
