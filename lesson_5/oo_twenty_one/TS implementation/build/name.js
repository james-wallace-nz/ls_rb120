"use strict";
const readline = require("readline");
function enterPlayerName() {
    let playerName = "";
    console.clear();
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    playerName = rl.question("What's your name?", function (name) {
        return name.toLowerCase();
    });
    rl.close();
    return playerName;
}
console.log(enterPlayerName());
//# sourceMappingURL=name.js.map