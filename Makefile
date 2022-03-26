.PHONY: build-puma-pg run-puma-pg docker-clean

build-puma-pg:
	docker build \
		--build-arg RAILS_ENV=production \
		--build-arg CAT_CHAT_DB_USER=postgres \
		--build-arg CAT_CHAT_DB_PW=${CAT_CHAT_DB_PW} \
		-t puma-pg -f ./Dockerfile-puma-pg .

run-puma-pg:
	docker run -p 3000:3000 --name app -d puma-pg

kill-puma-pg:
	docker kill app \
	docker rm app

docker-clean:
	docker system prune -a \
	docker image prune
