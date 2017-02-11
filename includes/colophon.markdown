---------- ------------------------------------------
*Date*     &cmd date "+%D %T" cmd&

*Computer* &cmd hostname | sed 's/\.local//g' cmd&

*MD5*      &cmd md5 -q $tempWorkingFile cmd&

*Compiler* [Octavo](https://github.com/OolonColoophid/octavo)

---------- ------------------------------------------

