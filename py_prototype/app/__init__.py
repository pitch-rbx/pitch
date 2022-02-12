from typing import List
from fastapi import FastAPI

from .models import Plugin, PluginAuthor, ThemedAsset

app = FastAPI()


@app.get("/plugins", response_model=List[Plugin])
def get_plugins():
    return [
        Plugin(
            version="2.3.6",
            name="Reclass",
            description="Test plugin",
            author=PluginAuthor(
                id=1670764,
                name="Elttob",
                display_name="Elttob"
            ),
            banner=ThemedAsset(
                light="rbxassetid://35664522",
                dark="rbxassetid://35664522",
                default="rbxassetid://35664522"
            ),
            icon=ThemedAsset(
                light="rbxassetid://35664522",
                dark="rbxassetid://35664522",
                default="rbxassetid://35664522"
            ),
            download_source="example.com"
        )
    ] * 5
