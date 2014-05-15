ChessServer
=======
API - Jogos
-----------

New game (POST)
-----------
* **Descrição**: Cria um novo jogo


* **PATH**: /api/v1/games/new_game(.formato)


* **Parâmetros**: player_name


* **Resposta**:


    1. code, message, game_id e player_key; Caso o jogo seja criado com sucesso

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/games/new_game.json?player_name=schettino


    {"code":0,"message":"Sucesso","game_id":1,"player_key":"c2fe7d67a01e61bec5281eb97a3864b82ad3b632"}


* **Exemplo de Erro**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/games/new_game.json


    {"code":1,"message":"Parâmetros insuficientes. Confira a documentação em https://github.com/bschettino/chessServer/blob/master/README.md"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR.

Join (POST)
-----------
* **Descrição**: Entra em um jogo já criado


* **PATH**: /api/v1/games/join(.formato)


* **Parâmetros**: player_name, game_id


* **Resposta**:


    1. code, message, board, player_key; Caso o jogador consiga entrar no jogo

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/games/join.json?player_name=bruno&game_id=1


    {"code":0,"message":"Sucesso","board":{"a1":"T","a2":"P","a3":"v","a4":"v","a5":"v","a6":"v","a7":"p","a8":"t",
    "b1":"C","b2":"P","b3":"v","b4":"v","b5":"v","b6":"v","b7":"p","b8":"c","c1":"B","c2":"P","c3":"v","c4":"v",
    "c5":"v","c6":"v","c7":"p","c8":"b","d1":"Q","d2":"P","d3":"v","d4":"v","d5":"v","d6":"v","d7":"p","d8":"q",
    "e1":"R","e2":"P","e3":"v","e4":"v","e5":"v","e6":"v","e7":"p","e8":"r","f1":"B","f2":"P","f3":"v","f4":"v",
    "f5":"v","f6":"v","f7":"p","f8":"b","g1":"C","g2":"P","g3":"v","g4":"v","g5":"v","g6":"v","g7":"p","g8":"c",
    "h1":"T","h2":"P","h3":"v","h4":"v","h5":"v","h6":"v","h7":"p","h8":"t"},
    "player_key":"79b73a924fef5def9fc6413f1433338a274a0ac9"}


* **Exemplo de Erro**:


    (POST) http://secure-scrubland-6759.herokuapp.com/api/v1/games/join.json?player_name=schettino&game_id=1


    {"code":3,"message":"Este jogador já participando do jogo"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GAME_NOT_FOUND.

Show (GET)
-----------
* **Descrição**: Exibe as informações de um jogo


* **PATH**: /api/v1/games/(id)(.formato)


* **Parâmetros**: id


* **Resposta**:


    1. code, message, game[board, next_player, over, winner]; Caso o jogo seja encontrado

    2. code, message; Caso ocorra algum erro


* **Exemplo de Sucesso**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/games/1.json


    {"code":0,"message":"Sucesso","game":{"board":{"a1":"T","a2":"P","a3":"v","a4":"v","a5":"v","a6":"v","a7":"p","a8":"t",
    "b1":"C","b2":"P","b3":"v","b4":"v","b5":"v","b6":"v","b7":"p","b8":"c","c1":"B","c2":"P","c3":"v","c4":"v","c5":"v",
    "c6":"v","c7":"p","c8":"b","d1":"Q","d2":"P","d3":"v","d4":"v","d5":"v","d6":"v","d7":"p","d8":"q","e1":"R","e2":"P",
    "e3":"v","e4":"v","e5":"v","e6":"v","e7":"p","e8":"r","f1":"B","f2":"P","f3":"v","f4":"v","f5":"v","f6":"v","f7":"p",
    "f8":"b","g1":"C","g2":"P","g3":"v","g4":"v","g5":"v","g6":"v","g7":"p","g8":"c","h1":"T","h2":"P","h3":"v","h4":"v",
    "h5":"v","h6":"v","h7":"p","h8":"t"},"next_player":"schettino","over":false,"winner":null}}


* **Exemplo de Erro**:


    (GET) http://secure-scrubland-6759.herokuapp.com/api/v1/games/2.json


    {"code":5,"message":"Jogo não encontrado"}

* **Possíveis códigos de retorno** [(Documentação)] (https://github.com/bschettino/chessServer/blob/master/doc/response_codes.md):


    CODE_ERROR_MISSING_PARAMETER, CODE_SUCCESS, CODE_UNKNOWN_ERROR, CODE_GAME_NOT_FOUND.


