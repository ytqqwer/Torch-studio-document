#! /bin/sh
cocos new -l cpp touhou-game
git clone git@github.com:ytqqwer/Touhou-Game.git touhou-game/remote
cd touhou-game
rm -r Classes Resources proj.android
mv remote/* remote/.* .  && rmdir remote

