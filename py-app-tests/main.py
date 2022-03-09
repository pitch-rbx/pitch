from fastapi import FastAPI, Response
from model.request import PasswordLoginBody, TokenLoginBody
from model.response import BaseResponse, ResponseTypeEnum
import requests

app = FastAPI()
apiKey = None


def verifyApiKey(key: str) -> bool:
    """Determines if the API key is valid.

    :param key: API key to verify.
    :return: If the API key is considered valid.
    """

    keyResponse = requests.get("https://itch.io/api/1/" + key + "/credentials/info")
    jsonResponse = keyResponse.json()
    return not ("errors" in jsonResponse.keys() and "invalid key" in jsonResponse["errors"])


@app.post("/itch/login/password", response_model=BaseResponse)
def itch_login_password(login: PasswordLoginBody, response: Response):
    """Handles a login request using a username and password.
    """

    # TODO: 2FA response not tested.
    # TODO: My guess is that 2FA codes will require storing some sort of token from the response and requiring the
    # TODO: client to send a new request that invokes POST https://api.itch.io/totp/verify with the token and the code
    # TODO: from the user. See: https://gist.github.com/csqrl/471bbb4a20f2f5f895ec8aae9126cf1c#totp-verify

    # Send the login request.
    loginResponse = requests.post("https://api.itch.io/login?force_recaptcha=true&source=desktop&username=" + login.username + "&password=" + login.password)
    responseJson = loginResponse.json()
    if loginResponse.status_code == 200:
        if "recaptcha_needed" in responseJson and responseJson["recaptcha_needed"]:
            # Return that a CAPTCHA is required.
            response.status_code = 409
            return {
                "response": ResponseTypeEnum.captcha_required
            }
        elif verifyApiKey(responseJson["key"]["key"]):
            # Grab the API key if the request was successful.
            global apiKey
            apiKey = responseJson["key"]["key"]
            print("API key obtained: " + apiKey)

            return {
                "response": ResponseTypeEnum.success,
                "inner_status_code": loginResponse.status_code,
            }
        else:
            # Return that the key is invalid.
            response.status_code = 401
            return {
                "response": ResponseTypeEnum.token_invalid
            }
    elif loginResponse.status_code == 400:
        if "Incorrect username or password" in responseJson["errors"]:
            # Return that the credentials were incorrect.
            response.status_code = 400
            return {
                "response": ResponseTypeEnum.credentials_invalid,
                "inner_status_code": loginResponse.status_code,
            }

    # Return HTTP 500 error (server error - unable to handle request)
    response.status_code = 500
    return {
        "response": ResponseTypeEnum.unknown_error,
        "inner_status_code": loginResponse.status_code,
    }


@app.post("/itch/login/token", response_model=BaseResponse)
def itch_login_token(login: TokenLoginBody, response: Response):
    """Handles a login request using an API token.
    """

    if verifyApiKey(login.token):
        # Store the API key if the request was successful.
        global apiKey
        apiKey = login.token
        print("API key obtained: " + apiKey)

        return {
            "response": ResponseTypeEnum.success,
        }
    else:
        # Return that the key is invalid.
        response.status_code = 401
        return {
            "response": ResponseTypeEnum.token_invalid
        }
