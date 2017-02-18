---------- ------------------------------------------
*Date*     &cmd date "+%D %T" cmd&

*Computer* &cmd hostname -s | sed 's/\.local//g' | sed 's/\b./\u&/g' cmd&

*MD5*      &cmd md5 -q $tempWorkingFile cmd&

*Compiler* [Octavo](https://github.com/OolonColoophid/octavo)

---------- ------------------------------------------

