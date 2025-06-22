<?php
include 'elements/layout/header.php';

require __DIR__ . '/config/db.php';

$id = $_GET['id'] ?? null;
if (! $id) {
    die('ID inválido');
}

$stmt = $pdo->prepare("SELECT * FROM veiculos WHERE id = ?");
$stmt->execute([$id]);
$veiculo = $stmt->fetch(PDO::FETCH_ASSOC);
if (! $veiculo) {
    die('Veículo não encontrado');
}
?>

<div class="container" style="padding-top:50px">
  <h2>Editar Veículo #<?= htmlspecialchars($veiculo['id']) ?></h2>

  <form id="formVeiculo" action="./src/controller.php?action=edit" method="POST">
    <input type="hidden" name="id" value="<?= htmlspecialchars($veiculo['id']) ?>">

    <div class="mb-3">
      <label for="placa" class="form-label">Placa</label>
      <input type="text" class="form-control" id="placa" name="placa" maxlength="10"
             value="<?= htmlspecialchars($veiculo['placa']) ?>" required>
    </div>

    <div class="mb-3">
      <label for="modelo" class="form-label">Modelo</label>
      <input type="text" class="form-control" id="modelo" name="modelo" maxlength="50"
             value="<?= htmlspecialchars($veiculo['modelo']) ?>" required>
    </div>

    <div class="mb-3">
      <label for="marca" class="form-label">Marca</label>
      <input type="text" class="form-control" id="marca" name="marca" maxlength="50"
             value="<?= htmlspecialchars($veiculo['marca']) ?>" required>
    </div>

    <div class="mb-3">
      <label for="ano_fabricacao" class="form-label">Ano de Fabricação</label>
      <input type="number" class="form-control" id="ano_fabricacao" name="ano_fabricacao"
             min="1900" max="<?= date('Y') ?>"
             value="<?= htmlspecialchars($veiculo['ano_fabricacao']) ?>" required>
    </div>

    <div class="mb-3">
      <label for="chassi" class="form-label">Chassi</label>
      <input type="text" class="form-control" id="chassi" name="chassi" maxlength="30"
             value="<?= htmlspecialchars($veiculo['chassi']) ?>" required>
    </div>

    <div class="mb-3">
      <label for="quilometragem" class="form-label">Quilometragem</label>
      <input type="number" class="form-control" id="quilometragem" name="quilometragem" min="0"
             value="<?= htmlspecialchars($veiculo['quilometragem']) ?>" required>
    </div>

    <button type="submit" class="btn btn-success">Salvar</button>
    <a href="index.php" class="btn btn-secondary">Cancelar</a>
  </form>
</div>
