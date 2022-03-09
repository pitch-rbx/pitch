from enum import Enum
from pydantic import BaseModel
from typing import Optional


class ResponseTypeEnum(str, Enum):
    success = "success"
    credentials_invalid = "credentials_invalid"
    token_invalid = "token_invalid"
    captcha_required = "captcha_required"
    token_required = "token_required"
    unknown_error = "unknown_error"


class BaseResponse(BaseModel):
    response: ResponseTypeEnum
    inner_status_code: Optional[int]
