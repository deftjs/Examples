@ECHO OFF
ECHO .
ECHO To use CoffeeScript, first install Node.js from nodejs.org
ECHO Next, download the CoffeeScript module by opening a command prompt and typing: npm install -g coffee-script
ECHO That's it.
ECHO .
ECHO .

call cake -s ../coffee -o ../app watchany
pause