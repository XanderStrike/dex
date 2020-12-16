![icon](icon.png)

# Dex

Dex is a very simple, brutalist Pokedex.

You can check it out here: https://dex.astandke.com/

On Android (and maybe iOS idk) you can add it to your home screen to make it super handy.

## Hosting

Run this yourself on your favorite container orchestration system.

For example in docker:

```
docker run -p 8080:80 xanderstrike/dex
```

## Development

This is basically a single purpose static site generator. Each Pokemon has a
partial in the `pokemon/` directory corresponding to it's national id, which is
built based on the template `pokemon/pokemon.html.erb`. To regenerate, cd to the
`pokemon` folder and run `ruby generate_templates.rb`.

For that reason, you can use any webserver to host this while you iterate on it.
I'm partial to this command:

```
docker run -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx

```

## License

MIT

Sprites courtesy of the [PokeAPI](https://github.com/PokeAPI/pokeapi).
