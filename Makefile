.PHONY: build-puma-pg run-puma-pg

build-puma-pg:
	docker build \
		--build-arg RAILS_ENV=production \
		--build-arg CAT_CHAT_DB_USER=postgres \
		--build-arg CAT_CHAT_DB_PW=${CAT_CHAT_DB_PW} \
		-t puma-pg -f ./Dockerfile-puma-pg .

run-puma-pg:
	docker run -p 3000:3000 --name app -d puma-pg