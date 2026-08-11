<!doctype html>
<html lang="pt-br">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> site de cadastro</title>
    <style>
        * { 
            margin: 0;
            padding: 0;
            box-sizing:border-box
        }
        body {
            font-family: Arial, Helvetica, sans-serif;
        background-color: #14081e;
    color: #fffbfb;
    display:flex;
    flex-direction:column;
    align-items: center;
    min-height: 100vh;      
 }

 header {

    background-color:rgb(0, 0, 0);
    color:rgb(232, 224, 224);
    width: 100%;
    text-align:center;
    padding: 30px 10px;
 }

 header h1 {
    font-size: 30px;
    margin-bottom: 8px;

 }
 main {
    width: 90%;
    max-width: 500px;
    margin-top: 40px;
 }

 form {
    background-color:rgb(35, 12, 44);
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);

 }

 .campo {
    margin-bottom: 15px;
    display: flex;
    flex-direction:column;

 }

 label {
    margin-bottom: 5px;
    font-weight: bold;
font-size: 15px;
 }

 input {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 7px;
    font-size: 16px;

 }

 input:focus {
    outline: none;
    border-color: #0e0e3a;
 }

 .erro {
    color: #e63956;
    font-size: 13px;
    display: block;
    margin-top: 12px;
 }

 button {
    width: 100%;
    padding: 14px;
    background-color: #093a25;
    color:aquamarine;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;

 }

 button:hover {
    background-color: #17303a;
 }

 #lista-cadastros {
    background-color:#f2f2f7;
    margin-top: 20px;
    padding: 22px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);

 }

 #lista-cadastro h2 {
    font-size: 18px;
    margin-bottom: 10px;
    color: #0f2232;
 }

 #lista-usuarios {
    list-style: none;
 }
 #lista-usuarios li {
    padding: 12px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
 }

 #lista-usuarios li:last-child {
    border-bottom: none;
 }

.btn-remover {
    background-color: #e63946;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
    cursor: pointer;
    font-size: 12px;
}

.btn-remover:hover {
    background-color: #c1121f;
}

footer {
    margin-top: auto;
    padding: 20px;
    color: #888;
    font-size: 14px;
}
    </style>
    </head>
    <body>
        <header>
            <h1> Cadastro de Usuário</h1>
            <p> Preencha os dados abaixo para se cadastrar</p><p>

    
            </header>
            <main>
                <form id=" form-cadastro">
                    <div class="campo">
                        <label for="nome"> Nome Completo: </label>
                       
                             <input type="text" id="nome" placeholder=" Digite seu nome" required>
                            
                    </div>
<div class="campo">
    <label for="senha"> senha: </label>
    <input type="password" id="senha" placeholder="Minimo 8 caracteres" required minlength="8">

</div>
<div class="campo">
    <label for="idade"> idade:</label>
    <input type="number" id="idade" placeholder="Sua idade" required min="1" max="120">

</div>
<span id="mensagem-erro" class="erro"></span>
<button type="submit"> cadastrar </button>

                </form>
                <section id="lista-cadastro">
                    <h2> Pessoas Cadastradas</h2>
                    <ul id="lista-usuarios"></ul>

                </section>
            </main>
            <footer>
                <p> Projeto de Cadastro de Usuarios </p>
            </footer>
            <script>
                var form = document.getElementById('form-cadastro');
                var campoNome = document.getElementById('nome');
                var campoEmail = document.getElementById('email');
                var campoSenha  = document.getElementById('senha');
                var campoIdade = document.getElementById('idade');
                var mensagemErro = document.getElementById('mensagem-erro');
                var listaUsuarios = document.getElementById('lista-usuarios');

                var usuarios = [];

                function carregarUsuarios() {
                    var dadosSalvos = localStorage.getItem('usuarios');
                    if (dadosSalvos) {
                        usuarios = JSON.parse(dadosSalvos);
                        renderizarLista();
                    }
                }
                function salvarUsuarios() {
                    localStorage.setItem('usuarios', JSON.stringify(usuarios));
                }
                function validarCadastro (nome, email, senha, idade) {
                    if(nome.length < 3) {
                        return 'O nome precisa ter pelo menos 3 letras.';
                    }
                    if(email.indexOf('@')=== -1) {
                        return 'Digite um e-mail valido.';
                    }
                    if(senha.length < 8) {
                        return ' A senha precisa ter pelo menos 8 caracteres.';

                    }
                    if(idade <= 0 || idade > 120) {
                        return 'Digite uma idade valida.';
                    }
                    var i;
                    for(i=0; i < usuarios.length; i = i + 1) {
                        if(usuarios[i].email === email) {
                            return 'Esse e-mail ja esta cadastrado.';

                        }
                    } 
                    return "";
                }
                function mostrarErro (texto) {
                    mensagemErro.textContent = texto;
                }
                function renderizarLista() {
                    listaUsuarios.innerHTML = '';
                    var i;
                    for(i=0; i < usuarios.length; i = i +1) {
                        var item = document.createElement('li');
                        var textoItem  = document.createTextNode('span');
                        textoItem.textContent = usuarios[i].nome + '(' + usuarios[i].idade + ' anos) -' + usuarios[i].email;
                        var botaoRemover = document.createElement('button');
                        botaoRemover.textContent = 'remover';
                        botaoRemover.className = 'btn-remover';
                        botaoRemover.setAttribute('data-indice', i);
                        botaoRemover.addEventListener('click', function(evento) {
                            var indice = evento.target.getAtribute('data-indice');
                            removerUsuario(indice);
                        });
                        item.appendChild(textoItem);
                        item.appendChild(botaoRemover);
                        listaUsuarios.appendChild(item);
                    }

                }
                function removerUsuario(indice) {
                    usuarios.splice(indice, 1);
                    salvarUsuarios();
                    renderizarLista();

                }
                function aoEnviarFormulario(evento) {
                    evento.preventDefalt();
                    var nome = campoNome.value;
                    var email = campoemail.value;
                    var senha = campoSenha.value;
                    var idade = campoIdade.value;
                    var erro = validarCadastro(nome, email, senha, idade);
                    if (erro !== '') {
                        mostrarErro(erro);
                        return;
                    }
                    mostrarErro('');
                    var novoUsuario = {
                        nome: nome,
                        email: email,
                        senha: senha,
                        idade: idade
                    };
                    usuarios.push(novoUsuario);
                    salvarUsuarios();
                    renderizarListas();
                    form.reset();
                }
                form.addEventListener('submit', aoEnviarFormulario);
                carregarUsuarios();
            </script>
            </body>
</html><!doctype html>
<html lang="pt-br">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> site de cadastro</title>
    <style>
        * { 
            margin: 0;
            padding: 0;
            box-sizing:border-box
        }
        body {
            font-family: Arial, Helvetica, sans-serif;
        background-color: #14081e;
    color: #fffbfb;
    display:flex;
    flex-direction:column;
    align-items: center;
    min-height: 100vh;      
 }

 header {

    background-color:rgb(0, 0, 0);
    color:rgb(232, 224, 224);
    width: 100%;
    text-align:center;
    padding: 30px 10px;
 }

 header h1 {
    font-size: 30px;
    margin-bottom: 8px;

 }
 main {
    width: 90%;
    max-width: 500px;
    margin-top: 40px;
 }

 form {
    background-color:rgb(35, 12, 44);
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);

 }

 .campo {
    margin-bottom: 15px;
    display: flex;
    flex-direction:column;

 }

 label {
    margin-bottom: 5px;
    font-weight: bold;
font-size: 15px;
 }

 input {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 7px;
    font-size: 16px;

 }

 input:focus {
    outline: none;
    border-color: #0e0e3a;
 }

 .erro {
    color: #e63956;
    font-size: 13px;
    display: block;
    margin-top: 12px;
 }

 button {
    width: 100%;
    padding: 14px;
    background-color: #093a25;
    color:aquamarine;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;

 }

 button:hover {
    background-color: #17303a;
 }

 #lista-cadastros {
    background-color:#f2f2f7;
    margin-top: 20px;
    padding: 22px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);

 }

 #lista-cadastro h2 {
    font-size: 18px;
    margin-bottom: 10px;
    color: #0f2232;
 }

 #lista-usuarios {
    list-style: none;
 }
 #lista-usuarios li {
    padding: 12px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
 }

 #lista-usuarios li:last-child {
    border-bottom: none;
 }

.btn-remover {
    background-color: #e63946;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
    cursor: pointer;
    font-size: 12px;
}

.btn-remover:hover {
    background-color: #c1121f;
}

footer {
    margin-top: auto;
    padding: 20px;
    color: #888;
    font-size: 14px;
}
    </style>
    </head>
    <body>
        <header>
            <h1> Cadastro de Usuário</h1>
            <p> Preencha os dados abaixo para se cadastrar</p><p>

    
            </header>
            <main>
                <form id=" form-cadastro">
                    <div class="campo">
                        <label for="nome"> Nome Completo: </label>
                       
                             <input type="text" id="nome" placeholder=" Digite seu nome" required>
                            
                    </div>
<div class="campo">
    <label for="senha"> senha: </label>
    <input type="password" id="senha" placeholder="Minimo 8 caracteres" required minlength="8">

</div>
<div class="campo">
    <label for="idade"> idade:</label>
    <input type="number" id="idade" placeholder="Sua idade" required min="1" max="120">

</div>
<span id="mensagem-erro" class="erro"></span>
<button type="submit"> cadastrar </button>

                </form>
                <section id="lista-cadastro">
                    <h2> Pessoas Cadastradas</h2>
                    <ul id="lista-usuarios"></ul>

                </section>
            </main>
            <footer>
                <p> Projeto de Cadastro de Usuarios </p>
            </footer>
            <script>
                var form = document.getElementById('form-cadastro');
                var campoNome = document.getElementById('nome');
                var campoEmail = document.getElementById('email');
                var campoSenha  = document.getElementById('senha');
                var campoIdade = document.getElementById('idade');
                var mensagemErro = document.getElementById('mensagem-erro');
                var listaUsuarios = document.getElementById('lista-usuarios');

                var usuarios = [];

                function carregarUsuarios() {
                    var dadosSalvos = localStorage.getItem('usuarios');
                    if (dadosSalvos) {
                        usuarios = JSON.parse(dadosSalvos);
                        renderizarLista();
                    }
                }
                function salvarUsuarios() {
                    localStorage.setItem('usuarios', JSON.stringify(usuarios));
                }
                function validarCadastro (nome, email, senha, idade) {
                    if(nome.length < 3) {
                        return 'O nome precisa ter pelo menos 3 letras.';
                    }
                    if(email.indexOf('@')=== -1) {
                        return 'Digite um e-mail valido.';
                    }
                    if(senha.length < 8) {
                        return ' A senha precisa ter pelo menos 8 caracteres.';

                    }
                    if(idade <= 0 || idade > 120) {
                        return 'Digite uma idade valida.';
                    }
                    var i;
                    for(i=0; i < usuarios.length; i = i + 1) {
                        if(usuarios[i].email === email) {
                            return 'Esse e-mail ja esta cadastrado.';

                        }
                    } 
                    return "";
                }
                function mostrarErro (texto) {
                    mensagemErro.textContent = texto;
                }
                function renderizarLista() {
                    listaUsuarios.innerHTML = '';
                    var i;
                    for(i=0; i < usuarios.length; i = i +1) {
                        var item = document.createElement('li');
                        var textoItem  = document.createTextNode('span');
                        textoItem.textContent = usuarios[i].nome + '(' + usuarios[i].idade + ' anos) -' + usuarios[i].email;
                        var botaoRemover = document.createElement('button');
                        botaoRemover.textContent = 'remover';
                        botaoRemover.className = 'btn-remover';
                        botaoRemover.setAttribute('data-indice', i);
                        botaoRemover.addEventListener('click', function(evento) {
                            var indice = evento.target.getAtribute('data-indice');
                            removerUsuario(indice);
                        });
                        item.appendChild(textoItem);
                        item.appendChild(botaoRemover);
                        listaUsuarios.appendChild(item);
                    }

                }
                function removerUsuario(indice) {
                    usuarios.splice(indice, 1);
                    salvarUsuarios();
                    renderizarLista();

                }
                function aoEnviarFormulario(evento) {
                    evento.preventDefalt();
                    var nome = campoNome.value;
                    var email = campoemail.value;
                    var senha = campoSenha.value;
                    var idade = campoIdade.value;
                    var erro = validarCadastro(nome, email, senha, idade);
                    if (erro !== '') {
                        mostrarErro(erro);
                        return;
                    }
                    mostrarErro('');
                    var novoUsuario = {
                        nome: nome,
                        email: email,
                        senha: senha,
                        idade: idade
                    };
                    usuarios.push(novoUsuario);
                    salvarUsuarios();
                    renderizarListas();
                    form.reset();
                }
                form.addEventListener('submit', aoEnviarFormulario);
                carregarUsuarios();
            </script>
            </body>
</html>
