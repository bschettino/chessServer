ChessServer
=======
API - Códigos de resposta
-----------

* CODE_SUCCESS = 0


    Retornou com sucesso

* CODE_ERROR_MISSING_PARAMETER = 1


    Algum parâmetro não foi passado

* CODE_UNKNOWN_ERROR = 2


    Erro não esperado (Favor notificar pelo email bschettino@id.uff.br ou no grupo do Facebook)

* CODE_ALREADY_PLAYING = 3


    Jogador já está participando do jogo

* CODE_MAX_NUMBER_REACHED = 4


    Número máximo de jogadores já foi atingido

* CODE_GAME_NOT_FOUND = 5


    Jogo não encontrado (verificar o parâmetro game_id)

* CODE_GAME_PLAYER_NOT_FOUND = 6


    Jogador não encontrado (verificar o parâmetro player_key)

* CODE_MOVE_NOT_FOUND = 7


    Jogada não encontrada (verificar o parâmetro move_id)

* CODE_PLAYER_CANT_VALIDATE = 8


    Um jogador não pode validar a própria jogada

* CODE_LAST_MOVE_NOT_VALIDATED = 9


    A última jogada ainda não foi validada

* CODE_LAST_MOVE_FROM_SAME_PLAYER = 10


    A última jogada foi realizada pelo mesmo jogador

* CODE_INVALID_BOOLEAN = 11


    Valor booleano inválido. Deve ser 'true' ou 'false'

* CODE_PLAYER_ONE_SHOULD_START_GAME = 12


    O jogador que criou o jogo deve fazer a primeira jogada

* CODE_WAITING_OTHER_PLAYER_VALIDATION = 13


    Aguardando validação do outro jogador


* CODE_GAME_FINISHED = 14


    Jogo encerrado

* CODE_REQUEST_REFUSED = 15


    Requisição de fim de jogo recusada

* CODE_NO_MOVES_TO_VALIDATE = 16


    Não existem jogadas para validar

* CODE_ALREADY_VALIDATED = 17


    Jogada já foi validada

* CODE_GOR_NOT_FOUND = 18


    Requisição de fim de jogo não encontrada (verificar parâmetro game_over_request_id)

* CODE_NO_GOR_TO_VALIDATE = 19


    Não existem requisições de fim de jogo para validar

* CODE_INVALID_RESULT = 20


    Resultado inválido. Deve ser -1 para derrota, 0 para empate e 1 para vitória

* CODE_INVALID_MOVE_TYPE = 21


    Tipo de jogada inválida. Confira a documentação em https://github.com/bschettino/chessServer/blob/master/doc/moves.md



