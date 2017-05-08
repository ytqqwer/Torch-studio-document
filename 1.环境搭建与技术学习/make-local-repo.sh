#! /bin/sh
cocos new -l cpp tohou-game
git clone git@github.com:ytqqwer/tohou-game.git tohou-game/remote
cd tohou-game
rm -r Classes Resource proj.android
mv -r remote/* remote/.* .  && rmdir remote

