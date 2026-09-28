#¡/bin/bash
#Level 8: Multi-File Searcher

#Mission: Create a script that searches for a specific word or phrase across all .log files in a directory and outputs the names of the files that contain the word or phrase.

DIRECTORY="Arena"
SEARCH_WORD="victory"  # Default search word, can be changed by user input

mkdir -p "Arena"
echo "The team achieved victory today" > Arena/battle1.log
echo "The enemy was defeated" > Arena/battle2.log
echo "victory was ours in the end" > Arena/battle3.log
echo "we lost the battle" > Arena/battle4.log

echo "--- Files containing '$SEARCH_WORD' ---"
grep -rl "$SEARCH_WORD" "$DIRECTORY"/*.log

echo "--- Search complete ---"
