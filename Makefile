build:
	docker build -t yujinlim/dogecoind .

deploy: login build
	docker tag yujinlim/dogecoind yujinlim/dogecoind:$(VERSION) &&\
	docker push yujinlim/dogecoind

login:
	docker login
