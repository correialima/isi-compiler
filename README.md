# IsiLanguage

Projeto desenvolvido na disciplina de Compiladores na UFABC.
O objetivo deste trabalho é desenvolver os aspectos práticos da IsiLanguage. Uma linguagem de programação imperativa muito próxima do Português estruturado. 

### Integrantes

Lucas Henrique Gois de Campos - RA: 11058015  
Rafael Correia de Lima        - RA: 21004515  
Renan Gonçalves Miranda       - RA: 11069212  
Thais ...                     - RA: 

## Gramática da IsiLanguage

As regras de produção abaixo re

Prog              -> **programa** Declara bloco **fimprog.**  
Declara           -> **declare** Id (',' Id)\*.  
Bloco             -> (Cmd.)+  
Cmd               -> CmdLeitura | CmdEscrita | CmdExpr | CmdIf  
CmdLeiutra        -> **leia** '(' Id ')'  
CmdEscrita        -> **escreva** '(' Texto | Id ')'  
CmdIf             -> **se** '(' Expr Op_rel Expr ')' **entao** '{' Cmd+ '}' ( **senao** '{' Cmd+ '}' )?  
CmdExpr           -> Id ':=' Expr  
Op_rel            -> '<' | '>' | '<=' | '>=' | '!=' | '=='  
Expr              -> Expre '+' Termo | Expr '-' Termo | Termo  
Termo             -> Termo '/' Fator  
Fator             -> Num | Id | ( Expr )  
Texto             -> "( 0..9 | a..z | A..Z | ' ' )+"  
Num               -> ( 0..9 ) +  
Id                -> ( a..z | A..Z ) ( a..z | A..Z | 0..9 )*  

## Requisitos Obrigatórios
O checklist abaixo detalha os requisitos obrigatórios mínimos no projeto.

| Requisito                                             | Status                    | Comentário |
| -------------                                         |:--------------:           |  ---  |
| Possui 2 tipos de variáveis                           | :heavy_check_mark: |                        |
| Possui a estrutura if..else                           |  |                         |
| 1ª Estrutura de Repetição                             |  |                         |
| Verificar se a variável foi atribuída ou não          |  |                       |
| Possui operações de Entrada e Saída                   |  |                        |      
| Aceita números decimais                               |  |                       |
| Verificar se variável doi declarada                   |  |                       |
| Verificar se variável declarada fou ou não usada      |  |                       |     
| Qual a linguagem destino? (C/Java/Python)             |  |                        |

## Requisitos Opcionais

| Requisito                                             | Status                    | Comentário |
| -------------                                         |:--------------:           |  ---  |
| Requisito                           |              | :heavy_check_mark:  |

# Vídeo Demonstração

