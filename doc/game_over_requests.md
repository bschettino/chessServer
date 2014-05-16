ChessServer
=======
API - Requisições de fim de jogo
-----------

New Game Over Request (POST)
-----------
* **Descrição**: Faz uma requisição de fim de jogo indicando se venceu ou perdeu o jogo


* **PATH**: /api/v1/game_over_requests/new_game_over_request(.formato)


* **Parâmetros**: game_id, player_key, result (Deve ser -1 para derrota, 0 para empate e 1 para vitória)


* **Resposta**:


    1. code, message, game_over_request_id; Caso a requisição seja criada ou aceita com sucesso

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso** (Requisição criada):


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/new_game_over_request.json?game_id=2&player_key=0f6b1ab0fcc518a997eb4edcb99ebe4ff79ba32c&result=1


    {"code":0,"message":"Sucesso","game_over_request_id":1}


* **Exemplo de Erro**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/new_game_over_request.json?game_id=2&player_key=77ce2f69c38594e0e9dc9bb456af8a936caffb71&result=1


    {"code":15,"message":"Requisição de fim de jogo recusada"}


* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_INVALID_RESULT, CODE_GAME_NOT_FOUND, CODE_GAME_PLAYER_NOT_FOUND, CODE_WAITING_OTHER_PLAYER_VALIDATION, CODE_GAME_FINISHED, CODE_REQUEST_REFUSED.


Waiting Validation (GET)
-----------
* **Descrição**: Mostra a requisição de fim de jogo do jogo especificado que está aguardando validação


* **PATH**: /api/v1/game_over_requests/waiting_validation(.formato)


* **Parâmetros**: game_id


* **Resposta**:


    1. code, message, game_over_request [game_id, winner, requestor, legal, validation_time]; Caso exista alguma jogada aguardando validação

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso** (Caso exista alguma jogada aguardando validação):


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/waiting_validation.json?game_id=2


    {"code":0,"message":"Sucesso","game_over_request":{"game_id":1,"winner":"bruno","requestor":"bruno","legal":null,"validation_time":null}}



* **Exemplo de Erro**:


    (GET)  http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/waiting_validation.json?game_id=2


    {"code":19,"message":"Sem requisições de fim de jogo para validar"}


* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GAME_NOT_FOUND, CODE_NO_GOR_TO_VALIDATE.


Show (GET)
-----------
* **Descrição**: Exibe as informações de uma requisição de fim de jogo


* **PATH**: /api/v1/game_over_requests/(id)(.formato)


* **Parâmetros**: id


* **Resposta**:


    1. code, message, game_over_request [game_id, winner, requestor, legal, validation_time]; Caso a requisição seja encontrada

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/1.json


    {"code":0,"message":"Sucesso","game_over_request":{"game_id":2,"winner":"bruno",
    "requestor":"bruno","legal":false,"validation_time":"2014-05-15T15:59:00-03:00"}}


* **Exemplo de Erro**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/game_over_requests/5.json


    {"code":18,"message":"Requisição de fim de jogo não encontrada"}


* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GOR_NOT_FOUND.