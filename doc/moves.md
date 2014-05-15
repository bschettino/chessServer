ChessServer
=======
API - Jogadas
-----------

New move (POST)
-----------
* **Descrição**: Cria uma nova jogada


* **PATH**: /api/v1/moves/new_move(.formato)


* **Parâmetros**: move_from, move_to, game_id, player_key

* Os parâmetros **move_from** e **move_to** devem ser passados como as **casas do tabuleiro**

        Por exemplo, para mover uma peça da casa a1 para casa c1, os parâmetros devem ser move_from = 'a1' e move_to = 'c1'

* **Resposta**:


    1. code, message, e move_id; Caso a jogada seja criada com sucesso

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/new_move.json?player_key=77ce2f69c38594e0e9dc9bb456af8a936caffb71&game_id=2&move_from=c1&move_to=d2


    {"code":0,"message":"Sucesso","move_id":1}


* **Exemplo de Erro**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/new_move.json?player_key=77ce2f69c38594e0e9dc9bb456af8a936caffb71&game_id=2&move_from=c1&move_to=d2


    {"code":9,"message":"A úlltima jogada ainda não foi validada"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GAME_NOT_FOUND, CODE_GAME_PLAYER_NOT_FOUND, CODE_LAST_MOVE_NOT_VALIDATED, CODE_LAST_MOVE_FROM_SAME_PLAYER, CODE_LAST_MOVE_FROM_SAME_PLAYER, CODE_PLAYER_ONE_SHOULD_START_GAMEß.


Waiting Validation (GET)
-----------
* **Descrição**: Mostra a jogada do jogo especificado que está aguardando validação


* **PATH**: /api/v1/moves/waiting_validation(.formato)


* **Parâmetros**: game_id


* **Resposta**:


    1. code, message, move_from, move_to, move_id; Caso exista alguma jogada aguardando validação

    2. code, message, board, next_player; Caso não exista nenhuma jogada aguardando validação

    3. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso** (Caso exista alguma jogada aguardando validação):


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/waiting_validation.json?game_id=2


    {"code":0,"message":"Sucesso","move_id":1,"move_from":"c1","move_to":"d2"}



* **Exemplo de Sucesso** (Caso não exista nenhuma jogada aguardando validação):


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/waiting_validation.json?game_id=2


    {"code":16,"message":"Sem jogadas para validar","board":{"a1":"T","a2":"P","a3":"v","a4":"v","a5":"v","a6":"v","a7":"p","a8":"t",
    "b1":"C","b2":"P","b3":"v","b4":"v","b5":"v","b6":"v","b7":"p","b8":"c","c2":"P","c3":"v","c4":"v","c5":"v",
    "c6":"v","c7":"p","c8":"b","d1":"Q","d3":"v","d4":"v","d5":"v","d6":"v","d7":"p","d8":"q","e1":"R","e2":"P",
    "e3":"v","e4":"v","e5":"v","e6":"v","e7":"p","e8":"r","f1":"B","f2":"P","f3":"v","f4":"v","f5":"v","f6":"v",
    "f7":"p","f8":"b","g1":"C","g2":"P","g3":"v","g4":"v","g5":"v","g6":"v","g7":"p","g8":"c","h1":"T","h2":"P",
    "h3":"v","h4":"v","h5":"v","h6":"v","h7":"p","c1":"v","h8":"t","d2":"B"},"next_player":"schettino"}


* **Exemplo de Erro**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/waiting_validation.json?game_id=5

    {"code":5,"message":"Jogo não encontrado"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GAME_NOT_FOUND, CODE_NO_MOVES_TO_VALIDATE.



Validate (POST)
-----------
* **Descrição**: Valida ou invalida uma jogada


* **PATH**: /api/v1/moves/validate(.formato)


* **Parâmetros**: move_id, player_key, valid


* **Resposta**:


    1. code, message, e board; Caso a jogada seja validada ou invalidada com sucesso

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/validate.json?move_id=1&player_key=0f6b1ab0fcc518a997eb4edcb99ebe4ff79ba32c&valid=true


    {"code":0,"message":"Sucesso","board":{"a1":"T","a2":"P","a3":"v","a4":"v","a5":"v","a6":"v","a7":"p","a8":"t",
    "b1":"C","b2":"P","b3":"v","b4":"v","b5":"v","b6":"v","b7":"p","b8":"c","c2":"P","c3":"v","c4":"v","c5":"v",
    "c6":"v","c7":"p","c8":"b","d1":"Q","d3":"v","d4":"v","d5":"v","d6":"v","d7":"p","d8":"q","e1":"R","e2":"P",
    "e3":"v","e4":"v","e5":"v","e6":"v","e7":"p","e8":"r","f1":"B","f2":"P","f3":"v","f4":"v","f5":"v","f6":"v",
    "f7":"p","f8":"b","g1":"C","g2":"P","g3":"v","g4":"v","g5":"v","g6":"v","g7":"p","g8":"c","h1":"T","h2":"P",
    "h3":"v","h4":"v","h5":"v","h6":"v","h7":"p","c1":"v","h8":"t","d2":"B"}}


* **Exemplo de Erro**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/validate.json?move_id=1&player_key=0f6b1ab0fcc518a997eb4edcb99ebe4ff79ba32c&valid=verdade


    {"code":11,"message":"Valor booleano inválido. Deve ser 'true' ou 'false'"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_INVALID_BOOLEAN, CODE_MOVE_NOT_FOUND, CODE_ALREADY_VALIDATED, CODE_GAME_PLAYER_NOT_FOUND, CODE_PLAYER_CANT_VALIDATE.

Show (GET)
-----------
* **Descrição**: Exibe as informações de uma jogada


* **PATH**: /api/v1/moves/(id)(.formato)


* **Parâmetros**: id


* **Resposta**:


    1. code, message, move [from, to, legal, validation_time}; Caso a jogada seja encontrada

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/1.json


    {"code":0,"message":"Sucesso","move":{"from":"c1","to":"d2","legal":true,"validation_time":"2014-05-15T15:34:45-03:00"}}


* **Exemplo de Erro**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/moves/2.json


    {"code":7,"message":"Jogada não encontrada"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_MOVE_NOT_FOUND.