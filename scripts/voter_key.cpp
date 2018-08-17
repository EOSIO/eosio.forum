#include <algorithm>
#include <cinttypes>
#include <iostream>
#include <sstream>

using namespace std;

typedef unsigned __int128 uint128_t;

static string toUpper(string& value);
static string toHex(uint64_t value);
static char char_to_symbol( char c );
static uint64_t string_to_name( const char* str );

int main(int argumentCount, const char** arguments) {
    if (argumentCount < 2) {
        cerr << "usage: vote_key proposal_name voter" << endl;
        return 1;
    }

    auto proposalName = arguments[1];
    auto voter = arguments[2];

    auto proposalNameValue = string_to_name(proposalName);
    auto voterValue = string_to_name(voter);

    auto voterKey = (((uint128_t) proposalNameValue) << 64 | (uint128_t) voterValue);

    cout << "Proposal name '" 
         << proposalName 
         << "' (dec " << proposalNameValue 
         << ", hex " << toHex(proposalNameValue)
         << ")" << endl;

    cout << "Voter '" 
         << voter 
         << "' (dec " << voterValue 
         << ", hex " << toHex(voterValue)
         << ")" << endl;

    char buffer[256];
    sprintf(buffer, "%016" PRIx64 "%016" PRIx64,(uint64_t)(voterKey>>64),(uint64_t)voterKey);
    string voterKeyString = string(buffer);

    string voterKeyBigEndianHex = toUpper(voterKeyString);

    cout << "Voter key" << endl 
         << " Big endian: 0x" << voterKeyBigEndianHex << endl
         << " Little endian: " << "!TODO" << endl;

    return 0;
}

static string toHex(uint64_t value) {
    std::stringstream stream;
    stream << "0x" << std::hex << value;
    auto hexString = stream.str();
    
    return toUpper(hexString);
}

static string toUpper(string& value) {
    std::transform(value.begin(), value.end(), value.begin(), ::toupper);
    return value;
}

static char char_to_symbol( char c ) {
    if( c >= 'a' && c <= 'z' )
        return (c - 'a') + 6;
    if( c >= '1' && c <= '5' )
        return (c - '1') + 1;
    return 0;
}

static uint64_t string_to_name( const char* str ) {

    uint32_t len = 0;
    while( str[len] ) ++len;

    uint64_t value = 0;

    for( uint32_t i = 0; i <= 12; ++i ) {
        uint64_t c = 0;
        if( i < len && i <= 12 ) c = uint64_t(char_to_symbol( str[i] ));

        if( i < 12 ) {
            c &= 0x1f;
            c <<= 64-5*(i+1);
        }
        else {
            c &= 0x0f;
        }

        value |= c;
    }

    return value;
}
