
<?php include 'elements/layout/header.php'; ?>
<?php
require __DIR__ . '/config/db.php'; 

$stmt = $pdo->query("SELECT * FROM veiculos ORDER BY id DESC");
$veiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);


?>

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
                    <td><?= $v['ano_fabricacao'] ?></td>
                    <td>
                        <a href="edit.php?id=<?= $v['id'] ?>" class="btn btn-warning btnEditar">
                            Editar
                        </a>
                        <a href="./src/controller.php?action=delete&id=<?= $v['id'] ?>" class="btn btn-danger" onclick="return confirm('Deseja excluir?')">
                            Deletar
                        </a>
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
