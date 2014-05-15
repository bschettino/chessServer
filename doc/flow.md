ChessServer
=======
API - Fluxo do jogo
-----------

* **Iniciar o jogo**:


        1. Jogador 1 cria o jogo (games/new_game)

        2. Jogador 2 entra no jogo (games/join)

* **Jogar**:


        3. Jogador 1 faz sua jogada (moves/new_move)

        4. Jogador 2 procura por jogadas a validar (moves/waiting_validation)

        5. Jogador 2 valida jogada (moves/validate) (Caso a jogada seja invalidada, o mesmo jogador vai jogar novamente)

        (Repete as chamadas 3, 4 e 5, alternando entre os jogadores, até que o jogo acabe)

* **Encerrar jogo**:


        6. Um jogador declara o fim do jogo, indicando que venceu ou perdeu o jogo (game_over_requests/new_game_over_request)

        7. O outro jogador declara o fim do jogo, indicando que venceu ou perdeu o jogo (game_over_requests/new_game_over_request)

        (Caso os dois jogadores indiquem que venceram o jogo, a requisição é invalidada e uma nova requisição deve ser criada)
