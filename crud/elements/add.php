<form id="formVeiculo" action="./src/controller.php?action=add" method="POST">

    <div class="mb-3">
        <label for="placa" class="form-label">Placa</label>
        <input type="text" class="form-control" id="placa" name="placa" maxlength="10" required>
    </div>

    <div class="mb-3">
        <label for="modelo" class="form-label">Modelo</label>
        <input type="text" class="form-control" id="modelo" name="modelo" maxlength="50" required>
    </div>

    <div class="mb-3">
        <label for="marca" class="form-label">Marca</label>
        <input type="text" class="form-control" id="marca" name="marca" maxlength="50" required>
    </div>

    <div class="mb-3">
        <label for="ano_fabricacao" class="form-label">Ano de Fabricação</label>
        <input type="number" class="form-control" id="ano_fabricacao" name="ano_fabricacao" min="1900" max="<?= date('Y') ?>" required>
    </div>

    <div class="mb-3">
        <label for="chassi" class="form-label">Chassi</label>
        <input type="text" class="form-control" id="chassi" name="chassi" maxlength="30" required>
    </div>

    <div class="mb-3">
        <label for="quilometragem" class="form-label">Quilometragem</label>
        <input type="number" class="form-control" id="quilometragem" name="quilometragem" min="0" required>
    </div>


    <button type="submit" class="btn btn-success">Salvar</button>
    <button type="button" id="btnCancelar" class="btn btn-secondary">Cancelar</button>
</form>
