# IsiLanguage

Projeto desenvolvido na disciplina de Compiladores na UFABC.
O objetivo deste trabalho é desenvolver os aspectos práticos da isilanguage. Uma linguagem de programação imperativa muito próxima do Português estruturado. 

### Integrantes

Lucas Henrique Gois de Campos - RA: 11058015  
Rafael Correia de Lima        - RA: 21004515  
Renan Gonçalves Miranda       - RA: 11069212  
Thais ...                     - RA: 

## Gramática da IsiLanguage

As regras de produção abaixo re
```
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
```
## Requisitos Obrigatórios
O checklist abaixo detalha os requisitos obrigatórios mínimos no projeto.

| Requisito                                             | Status                    | Comentário |
| -------------                                         |:--------------:           |  ---  |
| Possui 2 tipos de variáveis                           | :heavy_check_mark: | tipos: numero, texto                 |
| Possui a estrutura if..else                           | :heavy_check_mark:  | estrutura: se ... (senao ...)                        |
| 1ª Estrutura de Repetição                             | :heavy_check_mark:  | estrutura de repetição "enquanto"                        | 
| Verificar se a variável foi atribuída ou não          | :heavy_check_mark:  |                       |
| Possui operações de Entrada e Saída                   | :heavy_check_mark:  |                        |      
| Aceita números decimais                               | :heavy_check_mark:  |                      |
| Verificar se variável foi declarada                   | :heavy_check_mark:  |                       |
| Verificar se variável declarada foi ou não usada      | :heavy_check_mark:  |                       |     
| Qual a linguagem destino? (C/Java/Python)             | Python |                        |

## Requisitos Opcionais

| Requisito                                             | Status                    | Comentário |
| -------------                                         |:--------------:           |  ---  |
| Requisito                                             |              | :heavy_check_mark:  |

# Vídeo Demonstração

