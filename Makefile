.PHONY: image push

image:
	docker build -t euank/mastodon:$(shell git describe --tags) .

push: 
	docker push euank/mastodon:$(shell git describe --tags)
