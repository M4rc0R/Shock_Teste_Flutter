Bom(a) dia/tarde/noite!

Vou contar um pouco da experiencia que tive desenvolvento este projeto.

A unica extensão flutter que utilizei foi a http.

O aplicativo roda sem que a API esteja startada, porém, se não startar a API não será possivel logar para vizualizar a segunda tela.

---------Parte 1 - Front de formulário Usuário e Senha---------

Particularmente eu já tinha um conhecimento anterior ao projeto com o Flutter e por conta disso o front-end foi o que tive menos dificuldade.

Todo o front do formulário consegui fazer de forma simples usando TextEditingController para os campos usuário e senha em conjunto com o TextFormFild para gerar o formulário validando já no front se os campos estão vazios ou não.

Logo em seguida criei um ElevatedButton, onde são realizados todas as validações dos campos de usuário e senha, dentro de cada campo (Usuario e senha) criei um validator onde ao clicar no botão ele verifica se esses campos estão vazios.

A condição do botão é simples:

Se os campos de User e Senha estiverem vazios:
Será apresentado uma mensagem de "Digite sua senha" e/ou "Digite seu Usuário"
Se os campos de User e Senha estiverem preenchidos:
Será chamada a função "Logar()" que é onde faço as validações da informações em conjunto com a API criada.
---------Parte 2 - Validar e pegar informções da API no Flutter---------

Nesse segunda parte foi onde tive mais aprendizado já que nunca tinha realizado a integração do Flutter com API

A função Logar() basicamente se inicia mapeando as informções "user" e "senha" do _controleUsuario.text(TextEditingController) e _controleSenha.text(TextEditingController) e transformando-as em json para que a API consiga ler utilizando o jsonEncode().

Depois desse passo, a API valida se os texto enviados (_controleUsuario.text e _controleSenha.text) são existentes na API e coleta o retorno da mesma utilizando o jsonDecode(response.body) para pegar o valor da resposta "status"

As condições de resposta "status":

Se a resposta de "status" que vem da API for "Logado":

A aplicação fará duas terafas:
Apresentar uma mensagem "showSnackBar" na tela do usuário utilizando o ScaffoldMessenger com a mensagem de 'Logado com sucesso!'.
Utilizará o Navigator para 'navegar' até a proxima tela do aplicativo.
Se a resposta de "status" que vem da API "usuario ou senha invalidos":

Apresenta uma mensagem "showSnackBar" na tela do usuário utilizando o ScaffoldMessenger com a mensagem de 'Usuário ou senha invalidos'.
Se a resposta da API for um código diferente de 200 (response.statusCode != 200):

Apresenta uma mensagem "showSnackBar" na tela do usuário utilizando o ScaffoldMessenger com a mensagem genérica 'Servidor indisponivel'.
---------Parte 3 - Front para apresentação de imagens---------

Aqui eu tive novamente um bom aprendizado em como apresentar não só imagens, mas apresentar uma lista em si.

Foi criada uma função "Future<List> getAllImagens()" onde são pegas as informações de "descrição" e "imagem" que vem da API. Novamente eu utilizei o jsonDecode para que o Dart entenda as informações vindas da API

No body utilizei o FutureBuilder<List> para coletar as informações da função getAllImagens() com as condições:

Se não for encontrado nada dentro da API o aplicativo inicia CircularProgressIndicator() até encontrar algum valor.
Senão o aplicativo irá mostrar na tela as imagems utilizando o Image.network e o texto de descrição ( imagens.descricao).
---------Parte 4 - Informações da API---------

Criei um arquivo chamado imagens.dart onde contém uma class que faz a requisição da Imagem e da Descrição que vem da API.
