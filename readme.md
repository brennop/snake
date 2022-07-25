# Web Build

```bash
zip -9 -r snake.love lib/ objects/ shaders/ main.lua conf.lua
npx love.js -t snake -c snake.love build
cp index.html build/
```
