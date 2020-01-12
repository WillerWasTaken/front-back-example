front.tar.bz2: server.js package.json
	npm i
	tar cjvf front.tar.bz2 server.js package.json node_modules/

docker:
	docker build -t front-example .
