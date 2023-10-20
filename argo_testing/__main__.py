import time
from typer import Typer
from aiohttp import web
import logging

logging.basicConfig(level=logging.INFO)


cli = Typer()

router = web.RouteTableDef()


@router.get("/")
async def index(request: web.Request) -> web.Response:
    return web.Response(text="Hello World")


app = web.Application(logger=print)
app.router.add_routes(router)


@cli.command()
def server(port: int = 8000, host: str = "0.0.0.0"):
    web.run_app(app, host=host, port=port, access_log=logging)


@cli.command()
def migrate() -> None:
    print("Migrating")
    time.sleep(4)
    exit(1) # Simulate failure
    print("Migrated")


if __name__ == "__main__":
    cli()
