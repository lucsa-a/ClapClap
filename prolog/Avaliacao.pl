:- module(Avaliacao, [conta_erros_exercicio/2, conta_letras_licao/2, calcula_precisao_licao/3, exibe_estrelas_licao/2]).

:- use_module('./Utils.pl').

conta_letras([], 0).
conta_letras([_,_|Resto], Total) :-
    conta_letras(Resto, TotalResto),
    Total is TotalResto + 1.

conta_letras_licao(Exercicios, TotalLetras) :-
    flatten(Exercicios, Licao),
    conta_letras(Licao, TotalLetras).

conta_erros_exercicio([], 0).
conta_erros_exercicio([[_, "vermelho"]|Resto], Total) :-
    conta_erros_exercicio(Resto, TotalResto),
    Total is TotalResto + 1.
conta_erros_exercicio([[_, "verde"]|Resto], Total) :-
    conta_erros_exercicio(Resto, TotalResto),
    Total is TotalResto.

calcula_precisao_licao(TotalLetras, TotalErros, Precisao) :-
    Precisao is 100 * (TotalLetras - TotalErros) / TotalLetras.

exibe_estrelas_licao(Precisao, Estrelas) :-
    Precisao < 20.0,
    ler_arquivo("../dados/arteTxt/avaliacoes/zeroEstrela.txt"),
    insere_espaços(68, Espaços),
    format('~sSua precisão de acertos foi de: ~2f%', [Espaços, Precisao]). 
exibe_estrelas_licao(Precisao, Estrelas) :-
    Precisao =< 60.0,
    ler_arquivo("../dados/arteTxt/avaliacoes/licao/umaEstrela.txt"),
    insere_espaços(66, Espaços),
    format('~sSua precisão de acertos foi de: ~2f%', [Espaços, Precisao]).
exibe_estrelas_licao(Precisao, Estrelas) :-
    Precisao =< 90.0,
    ler_arquivo("../dados/arteTxt/avaliacoes/duasEstrelas.txt"),
    insere_espaços(66, Espaços),
    format('~sSua precisão de acertos foi de: ~2f%', [Espaços, Precisao]).
exibe_estrelas_licao(Precisao, Estrelas) :-
    ler_arquivo("../dados/arteTxt/avaliacoes/licao/tresEstrelas.txt"),
    insere_espaços(64, Espaços),
    format('~sSua precisão de acertos foi de: ~2f%', [Espaços, Precisao]).