![icon](icon.png)

# Dex

Dex is a very simple, brutalist Pokedex.

Inspired by (but markedly inferior to) [Pokedex.org](https://pokedex.org/).
Though at the time of writing, that app is only complete up to Generation V, and
does not successfully build on my machine, which is a problem because I've grown
quite dependent on it and now want to play a Generation VI game.

You can check it out here: https://dex.astandke.com/

On Android (and maybe iOS idk) you can add it to your home screen to make it super handy.

Despite having beat every Pokemon game at least once, I'm quite ignorant of the
complex underpinnings of the Pokemon battle system. I find myself only ever
interested in two things: what types of attacks a rival pokemon is weak to, and
which attacks a given Pokemon can learn. Therefore, this app only exposes those
two pieces of information.

## Hosting

Run this yourself on your favorite container orchestration system.

For example in docker:

```
docker run -p 8080:80 xanderstrike/dex
```

## Development

All the logic lives in index.html, the json is simply massaged data from the
PokeAPI CSV dumps.

## License

MIT

Sprites courtesy of the [PokeAPI](https://github.com/PokeAPI/pokeapi).
