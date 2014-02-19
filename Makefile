NAME = pblittle/base
VERSION = 0.2.1

build:
	docker build -rm -t $(NAME):$(VERSION) .

run:
	docker run -d \
		-p 22 \
		-name base \
		$(NAME):$(VERSION)

tag:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release:
	docker push $(NAME)

shell:
	docker run -t -i -rm $(NAME):$(VERSION) bash
