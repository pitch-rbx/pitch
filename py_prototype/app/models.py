from typing import Optional
from pydantic import BaseModel, stricturl

rbx_content_url = stricturl(
    tld_required=False,
    allowed_schemes={
        "rbxasset",
        "rbxassetid"
    }
)


class ThemedAsset(BaseModel):
    dark: Optional[rbx_content_url]
    light: Optional[rbx_content_url]
    default: rbx_content_url


class PluginAuthor(BaseModel):
    id: int
    name: str
    display_name: str


class Plugin(BaseModel):
    version: str
    name: str
    description: str
    author: PluginAuthor

    icon: ThemedAsset
    banner: ThemedAsset

    download_source: str
