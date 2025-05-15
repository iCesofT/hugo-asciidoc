# hugo-asciidoc

[HUGO](https://gohugo.io/) Docker Image with [AsciiDoc](https://asciidoc.org/) support.

## Docker image

The Docker image is available on [Docker Hub](https://hub.docker.com/r/fjahijado/hugo), and it is built from the `Dockerfile` in this repository.

It was built for amd64 and arm64 architectures:

```shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg HUGO_VERSION=0.147.3 -t fjahijado/hugo:0.147.3 --push . 
``` 

## Usage

You can use this image to build your Hugo site with AsciiDoc support. For example:

```shell
docker run --rm -v $(pwd):/hugo-project -v $(pwd)/docs:/docs fjahijado/hugo:${HUGO_VERSION} hugo --gc --minify --baseURL "<baseUrl>" --destination /docs --theme <theme>
```

or you can use the `docker-compose.yaml` file. Firstable create a `.env` file:

```text
# .env
HUGO_VERSION=0.147.3
BASE_URL=https://yourdomain.com/
HUGO_THEME=your-theme
```

And then run Hugo:

```shell
docker-compose up -d hugo
```

