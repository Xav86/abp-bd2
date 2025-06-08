
<?php include 'elements/layout/header.php'; ?>
<?php include 'dados.php'; ?>

<div style="padding-top: 50px;" class="container">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 id="title">Veículos</h2>
        <button class="btn btn-primary btnNovo">+ Novo veículo</button>
    </div>

    <div id="actions">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Modelo</th>
                    <th>Ano</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($veiculos as $v): ?>
                <tr>
                    <td><?= $v['id'] ?></td>
                    <td><?= $v['modelo'] ?></td>
                    <td><?= $v['ano'] ?></td>
                    <td>
                        <button class="btn btn-warning btnEditar"> 
                            Editar
                        </button>
    
                        <button class="btn btn-warning">
                            Deletar
                        </button>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

    <div style="display: none;" id="formEdit">
        <?php include 'elements/edit.php'; ?>
    </div>

    <div style="display: none;" id="formAdd">
        <?php include 'elements/add.php'; ?>
    </div>


</div>
