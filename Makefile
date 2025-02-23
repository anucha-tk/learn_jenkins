build:
	docker compose build
start:
	docker compose up -d
stop:
	docker compose stop
down:
	docker compose down
restart:
	docker compose restart
logs:
	docker compose logs
access:
	@read -p "Enter container name: " c; docker exec -it $$c bash
