document.addEventListener('DOMContentLoaded', () => {
    const btnNovo = document.getElementsByClassName('btnNovo');
    const formEdit = document.getElementById('formEdit');
    const formAdd = document.getElementById('formAdd');
    const actions = document.getElementById('actions');
    const listar = document.getElementById('listar');
    const title = document.getElementById('title');

    Array.from(btnNovo).forEach(btnNovo => {
        btnNovo.addEventListener('click', () => {
            formAdd.style.display = 'block';
            formEdit.style.display = 'none';
            actions.style.display = 'none';
            title.innerHTML = "Veículos - Adicionar"
        });
    });

    listar.addEventListener('click', () => {
        actions.style.display = 'block';
        formAdd.style.display = 'none';
        formEdit.style.display = 'none';
        title.innerHTML = "Veículos"
    });

    document.querySelectorAll('.btnEditar').forEach(botao => {
        botao.addEventListener('click', () => {
            formEdit.style.display = 'block';
            actions.style.display = 'none';
            formAdd.style.display = 'none';
            title.innerHTML = "Veículos - Editar"
        });
    });
});