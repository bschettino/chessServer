ChessServer
=======
API - Tabuleiro
-----------

* Peças do jogador 1 são representadas em letras **MAIÚSCULAS** e as do jogador 2, em **minúsculas**


* **Peças**:

        Torre: 't'
        Cavalo: 'c'
        Bispo: 'b'
        Rainha: 'q'
        Rei: 'r'
        Peão: 'p'
        Casa vazia: 'v'


* **Representação do tabuleiro na API**:


        "board":{"a1":"T","a2":"P","a3":"v","a4":"v","a5":"v","a6":"v","a7":"p","a8":"t","b1":"C","b2":"P","b3":"v",
        "b4":"v","b5":"v","b6":"v","b7":"p","b8":"c","c1":"B","c2":"P","c3":"v","c4":"v","c5":"v","c6":"v","c7":"p",
        "c8":"b","d1":"Q","d2":"P","d3":"v","d4":"v","d5":"v","d6":"v","d7":"p","d8":"q","e1":"R","e2":"P","e3":"v",
        "e4":"v","e5":"v","e6":"v","e7":"p","e8":"r","f1":"B","f2":"P","f3":"v","f4":"v","f5":"v","f6":"v","f7":"p",
        "f8":"b","g1":"C","g2":"P","g3":"v","g4":"v","g5":"v","g6":"v","g7":"p","g8":"c","h1":"T","h2":"P","h3":"v",
        "h4":"v","h5":"v","h6":"v","h7":"p","h8":"t"}

        (Por exemplo, a entrada "a1":"T" significa que uma Torre do jogador 1 está na casa a1 do tabuleiro)